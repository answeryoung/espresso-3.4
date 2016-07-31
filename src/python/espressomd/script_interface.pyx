cdef class  PScriptInterface:
    def __init__(self, name):
        self.sip = factory_make[ScriptInterfaceBase](name)
        self.parameters = self.sip.get().all_parameters()

    cdef Variant make_variant(self, ParameterType type, value):
        if <int> type == <int> BOOL:
            return make_variant[bool](<bool> value)
        if <int> type == <int> INT:
            return make_variant[int](<int> value)
        if <int> type == <int> DOUBLE:
            return make_variant[double](<double> value)
        if <int> type == <int> STRING:
            return make_variant[string](<string> value)
        if <int> type == <int> INT_VECTOR:
            return make_variant[vector[int] ](<vector[int]> value)
        if <int> type == <int> DOUBLE_VECTOR:
            return make_variant[vector[double] ](<vector[double]> value)
        if <int> type == <int> VECTOR3D:
            return make_variant[Vector3d](Vector3d(<vector[double]> value))
        if <int> type == <int> VECTOR2D:
            return make_variant[Vector2d](Vector2d(<vector[double]> value))

        raise Exception("Unkown type")

    def set_parameter(self, **kwargs):
        cdef ParameterType type

        for name in kwargs:
            try:
                self.parameters.at(name)
            except:
                raise ValueError("Unknown parameter %s" %name)

            type = self.parameters[name].type()
            
            if <int> type == <int> INT_VECTOR\
               or <int> type == <int> DOUBLE_VECTOR:
                n_elements = self.parameters[name].n_elements()
                if not (len(kwargs[name]) == n_elements ):
                    raise ValueError("Value of %s expected to be %i long" %(name, n_elements))

            self.sip.get().set_parameter(name, self.make_variant(type, kwargs[name]))


    def get_parameter(self, name):
        cdef ParameterType type = self.parameters[name].type()
        cdef Variant value = self.sip.get().get_parameter(name)

        if <int> type == <int> BOOL:
            return get[bool](value)
        if <int> type == <int> INT:
            return get[int](value)
        if <int> type == <int> DOUBLE:
            return get[double](value)
        if <int> type == <int> STRING:
            return get[string](value)
        if <int> type == <int> INT_VECTOR:
            return get[vector[int] ](value)
        if <int> type == <int> DOUBLE_VECTOR:
            return get[vector[double] ](value)
        if <int> type == <int> VECTOR3D:
            return get[Vector3d](value).as_vector()
        if <int> type == <int> VECTOR2D:
            return get[Vector2d](value).as_vector()

        raise Exception("Unkown type")

    def get_parameters(self):
        odict = {}
        for pair in self.parameters:
            odict[pair.first] = self.get_parameter(pair.first)
        return odict

initialize()

