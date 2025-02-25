// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.type.AnyFunctionType
import codeql.swift.elements.type.GenericTypeParamType

module Generated {
  /**
   * The type of a generic function with type parameters
   */
  class GenericFunctionType extends Synth::TGenericFunctionType, AnyFunctionType {
    override string getAPrimaryQlClass() { result = "GenericFunctionType" }

    /**
     * Gets the `index`th type parameter of this generic type (0-based).
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    GenericTypeParamType getImmediateGenericParam(int index) {
      result =
        Synth::convertGenericTypeParamTypeFromRaw(Synth::convertGenericFunctionTypeToRaw(this)
              .(Raw::GenericFunctionType)
              .getGenericParam(index))
    }

    /**
     * Gets the `index`th type parameter of this generic type (0-based).
     */
    final GenericTypeParamType getGenericParam(int index) {
      result = this.getImmediateGenericParam(index).resolve()
    }

    /**
     * Gets any of the type parameters of this generic type.
     */
    final GenericTypeParamType getAGenericParam() { result = this.getGenericParam(_) }

    /**
     * Gets the number of type parameters of this generic type.
     */
    final int getNumberOfGenericParams() { result = count(int i | exists(this.getGenericParam(i))) }
  }
}
