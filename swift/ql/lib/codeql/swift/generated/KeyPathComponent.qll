// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Argument
import codeql.swift.elements.AstNode
import codeql.swift.elements.type.Type
import codeql.swift.elements.decl.ValueDecl

module Generated {
  /**
   * A component of a `KeyPathExpr`.
   */
  class KeyPathComponent extends Synth::TKeyPathComponent, AstNode {
    override string getAPrimaryQlClass() { result = "KeyPathComponent" }

    /**
     * Gets the kind of key path component.
     *
     * INTERNAL: Do not use.
     *
     * This is 3 for properties, 4 for array and dictionary subscripts, 5 for optional forcing
     * (`!`), 6 for optional chaining (`?`), 7 for implicit optional wrapping, 8 for `self`,
     * and 9 for tuple element indexing.
     *
     * The following values should not appear: 0 for invalid components, 1 for unresolved
     * properties, 2 for unresolved subscripts, 10 for #keyPath dictionary keys, and 11 for
     * implicit IDE code completion data.
     */
    int getKind() {
      result = Synth::convertKeyPathComponentToRaw(this).(Raw::KeyPathComponent).getKind()
    }

    /**
     * Gets the `index`th argument to an array or dictionary subscript expression (0-based).
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    Argument getImmediateSubscriptArgument(int index) {
      result =
        Synth::convertArgumentFromRaw(Synth::convertKeyPathComponentToRaw(this)
              .(Raw::KeyPathComponent)
              .getSubscriptArgument(index))
    }

    /**
     * Gets the `index`th argument to an array or dictionary subscript expression (0-based).
     */
    final Argument getSubscriptArgument(int index) {
      result = this.getImmediateSubscriptArgument(index).resolve()
    }

    /**
     * Gets any of the arguments to an array or dictionary subscript expression.
     */
    final Argument getASubscriptArgument() { result = this.getSubscriptArgument(_) }

    /**
     * Gets the number of arguments to an array or dictionary subscript expression.
     */
    final int getNumberOfSubscriptArguments() {
      result = count(int i | exists(this.getSubscriptArgument(i)))
    }

    /**
     * Gets the tuple index of this key path component, if it exists.
     */
    int getTupleIndex() {
      result = Synth::convertKeyPathComponentToRaw(this).(Raw::KeyPathComponent).getTupleIndex()
    }

    /**
     * Holds if `getTupleIndex()` exists.
     */
    final predicate hasTupleIndex() { exists(this.getTupleIndex()) }

    /**
     * Gets the property or subscript operator, if it exists.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    ValueDecl getImmediateDeclRef() {
      result =
        Synth::convertValueDeclFromRaw(Synth::convertKeyPathComponentToRaw(this)
              .(Raw::KeyPathComponent)
              .getDeclRef())
    }

    /**
     * Gets the property or subscript operator, if it exists.
     */
    final ValueDecl getDeclRef() { result = this.getImmediateDeclRef().resolve() }

    /**
     * Holds if `getDeclRef()` exists.
     */
    final predicate hasDeclRef() { exists(this.getDeclRef()) }

    /**
     * Gets the return type of this component application.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    Type getImmediateComponentType() {
      result =
        Synth::convertTypeFromRaw(Synth::convertKeyPathComponentToRaw(this)
              .(Raw::KeyPathComponent)
              .getComponentType())
    }

    /**
     * Gets the return type of this component application.
     *
     * An optional-chaining component has a non-optional type to feed into the rest of the key
     * path; an optional-wrapping component is inserted if required to produce an optional type
     * as the final output.
     */
    final Type getComponentType() { result = this.getImmediateComponentType().resolve() }
  }
}
