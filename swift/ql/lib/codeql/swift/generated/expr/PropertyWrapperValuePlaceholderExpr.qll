// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.expr.OpaqueValueExpr

module Generated {
  /**
   * A placeholder substituting property initializations with `=` when the property has a property
   * wrapper with an initializer.
   */
  class PropertyWrapperValuePlaceholderExpr extends Synth::TPropertyWrapperValuePlaceholderExpr,
    Expr
  {
    override string getAPrimaryQlClass() { result = "PropertyWrapperValuePlaceholderExpr" }

    /**
     * Gets the wrapped value of this property wrapper value placeholder expression, if it exists.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    Expr getImmediateWrappedValue() {
      result =
        Synth::convertExprFromRaw(Synth::convertPropertyWrapperValuePlaceholderExprToRaw(this)
              .(Raw::PropertyWrapperValuePlaceholderExpr)
              .getWrappedValue())
    }

    /**
     * Gets the wrapped value of this property wrapper value placeholder expression, if it exists.
     */
    final Expr getWrappedValue() { result = this.getImmediateWrappedValue().resolve() }

    /**
     * Holds if `getWrappedValue()` exists.
     */
    final predicate hasWrappedValue() { exists(this.getWrappedValue()) }

    /**
     * Gets the placeholder of this property wrapper value placeholder expression.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    OpaqueValueExpr getImmediatePlaceholder() {
      result =
        Synth::convertOpaqueValueExprFromRaw(Synth::convertPropertyWrapperValuePlaceholderExprToRaw(this)
              .(Raw::PropertyWrapperValuePlaceholderExpr)
              .getPlaceholder())
    }

    /**
     * Gets the placeholder of this property wrapper value placeholder expression.
     */
    final OpaqueValueExpr getPlaceholder() { result = this.getImmediatePlaceholder().resolve() }
  }
}
