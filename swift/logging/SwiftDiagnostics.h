#pragma once

#include <binlog/binlog.hpp>
#include <string>
#include <vector>
#include <unordered_map>
#include <optional>
#include <cassert>
#include <fstream>
#include <filesystem>
#include <sstream>
#include <mutex>
#include <fmt/format.h>
#include <fmt/chrono.h>
#include <nlohmann/json.hpp>

namespace codeql {

extern const std::string_view programName;

struct SwiftDiagnosticsLocation {
  std::string_view file;
  unsigned startLine;
  unsigned startColumn;
  unsigned endLine;
  unsigned endColumn;

  nlohmann::json json() const;
  std::string str() const;
};

// Models a diagnostic source for Swift, holding static information that goes out into a diagnostic
// These are internally stored into a map on id's. A specific error log can use binlog's category
// as id, which will then be used to recover the diagnostic source while dumping.
struct SwiftDiagnostic {
  enum class Format {
    plaintext,
    markdown,
  };

  enum class Visibility : unsigned char {
    none = 0b000,
    statusPage = 0b001,
    cliSummaryTable = 0b010,
    telemetry = 0b100,
    all = 0b111,
  };

  // Notice that Tool Status Page severity is not necessarily the same as log severity, as the
  // scope is different: TSP's scope is the whole analysis, log's scope is a single run
  enum class Severity {
    note,
    warning,
    error,
  };

  // wrapper for passing optional help links to constructor
  struct HelpLinks {
    std::string_view value;
  };

  static constexpr std::string_view extractorName = "swift";

  std::string_view id;
  std::string_view name;
  std::string_view action;

  Format format{Format::markdown};
  Visibility visibility{Visibility::all};
  Severity severity{Severity::error};

  // space separated if more than 1. Not a vector to allow constexpr
  // TODO(C++20) with vector going constexpr this can be turned to `std::vector<std::string_view>`
  std::string_view helpLinks{""};

  std::optional<SwiftDiagnosticsLocation> location{};

  // notice help links are really required only for plaintext messages, otherwise they should be
  // directly embedded in the markdown message
  // optional arguments can be any of HelpLinks, Severity, Visibility or Format to set the
  // corresponding field
  // TODO(C++20) this constructor won't really be necessary anymore with designated initializers
  template <typename... OptionalArgs>
  constexpr SwiftDiagnostic(std::string_view id,
                            std::string_view name,
                            std::string_view action,
                            OptionalArgs... optionalArgs)
      : id{id}, name{name}, action{action} {
    (setOptionalArg(optionalArgs), ...);
  }

  // create a JSON diagnostics for this source with the given `timestamp` and `message`
  // Depending on format, either a plaintextMessage or markdownMessage is used that includes both
  // the message and the action to take. A dot '.' is appended to `message`. The id is used to
  // construct the source id in the form `swift/<prog name>/<id>`
  nlohmann::json json(const std::chrono::system_clock::time_point& timestamp,
                      std::string_view message) const;

  // returns <id> or <id>@<location> if a location is present
  std::string abbreviation() const;

  SwiftDiagnostic withLocation(std::string_view file,
                               unsigned startLine = 0,
                               unsigned startColumn = 0,
                               unsigned endLine = 0,
                               unsigned endColumn = 0) const {
    auto ret = *this;
    ret.location = SwiftDiagnosticsLocation{file, startLine, startColumn, endLine, endColumn};
    return ret;
  }

 private:
  bool has(Visibility v) const;

  constexpr void setOptionalArg(HelpLinks h) { helpLinks = h.value; }
  constexpr void setOptionalArg(Format f) { format = f; }
  constexpr void setOptionalArg(Visibility v) { visibility = v; }
  constexpr void setOptionalArg(Severity s) { severity = s; }

  // intentionally left undefined
  template <typename T>
  constexpr void setOptionalArg(T);
};

inline constexpr SwiftDiagnostic::Visibility operator|(SwiftDiagnostic::Visibility lhs,
                                                       SwiftDiagnostic::Visibility rhs) {
  return static_cast<SwiftDiagnostic::Visibility>(static_cast<unsigned char>(lhs) |
                                                  static_cast<unsigned char>(rhs));
}

inline constexpr SwiftDiagnostic::Visibility operator&(SwiftDiagnostic::Visibility lhs,
                                                       SwiftDiagnostic::Visibility rhs) {
  return static_cast<SwiftDiagnostic::Visibility>(static_cast<unsigned char>(lhs) &
                                                  static_cast<unsigned char>(rhs));
}

constexpr SwiftDiagnostic internalError{
    "internal-error",
    "Internal error",
    "Some or all of the Swift analysis may have failed.\n"
    "\n"
    "If the error persists, contact support, quoting the error message and describing what "
    "happened, or [open an issue in our open source repository][1].\n"
    "\n"
    "[1]: https://github.com/github/codeql/issues/new?labels=bug&template=ql---general.md",
    SwiftDiagnostic::Severity::warning,
};
}  // namespace codeql
