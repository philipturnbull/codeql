import java
import semmle.code.java.security.ImplicitPendingIntentsQuery
import TestUtilities.InlineExpectationsTest

class ImplicitPendingIntentsTest extends InlineExpectationsTest {
  ImplicitPendingIntentsTest() { this = "ImplicitPendingIntentsTest" }

  override string getARelevantTag() { result = ["hasImplicitPendingIntent"] }

  override predicate hasActualResult(Location location, string element, string tag, string value) {
    tag = "hasImplicitPendingIntent" and
    exists(DataFlow::Node sink | ImplicitPendingIntentStartFlow::flowTo(sink) |
      sink.getLocation() = location and
      element = sink.toString() and
      value = ""
    )
  }
}
