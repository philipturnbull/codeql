// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.stmt.LabeledConditionalStmt
import codeql.swift.elements.stmt.Stmt

module Generated {
  class WhileStmt extends Synth::TWhileStmt, LabeledConditionalStmt {
    override string getAPrimaryQlClass() { result = "WhileStmt" }

    /**
     * Gets the body of this while statement.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    Stmt getImmediateBody() {
      result =
        Synth::convertStmtFromRaw(Synth::convertWhileStmtToRaw(this).(Raw::WhileStmt).getBody())
    }

    /**
     * Gets the body of this while statement.
     */
    final Stmt getBody() { result = this.getImmediateBody().resolve() }
  }
}
