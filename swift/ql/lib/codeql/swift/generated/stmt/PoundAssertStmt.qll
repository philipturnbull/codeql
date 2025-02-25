// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.stmt.Stmt

module Generated {
  class PoundAssertStmt extends Synth::TPoundAssertStmt, Stmt {
    override string getAPrimaryQlClass() { result = "PoundAssertStmt" }

    /**
     * Gets the condition of this pound assert statement.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    Expr getImmediateCondition() {
      result =
        Synth::convertExprFromRaw(Synth::convertPoundAssertStmtToRaw(this)
              .(Raw::PoundAssertStmt)
              .getCondition())
    }

    /**
     * Gets the condition of this pound assert statement.
     */
    final Expr getCondition() { result = this.getImmediateCondition().resolve() }

    /**
     * Gets the message of this pound assert statement.
     */
    string getMessage() {
      result = Synth::convertPoundAssertStmtToRaw(this).(Raw::PoundAssertStmt).getMessage()
    }
  }
}
