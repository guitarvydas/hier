  $expression__NewScope                            # {expression
    $ekind__NewScope                               # {ekind
      $ekind__SetEnum_object                       # 'object'
    $ekind__Output                                 # }
    $expression__SetField_ekind_from_ekind         # ->.ekind
    $object__NewScope                              # {object
      $name__NewScope                              # {name
        $name__GetName                             # GetName
      $name__Output                                # }
      $object__SetField_name_from_name             # ->.name
      $fieldMap__NewScope                          # {fieldMap
        $field__NewScope                           # {field
          $name__NewScope                          # {name
            $name__GetName                         # GetName
          $name__Output                            # }
          $field__SetField_name_from_name          # ->.name
          $parameterList__NewScope                 # {parameterList
            $name__NewScope                        # {name
              $name__GetName                       # GetName
            $name__Output
            $parameterList__AppendFrom_name        # }+
          $parameterList__Output                   # }
          $field__SetField_parameterList_from_parameterList # ->.parameterList
        $field__Output
        $fieldMap__AppendFrom_field                # }+
      $fieldMap__Output                            # }
      $object__SetField_fieldMap_from_fieldMap     # ->.fieldMap
    $object__Output                                # }
    $expression__SetField_object_from_object       # ->.object
  $expression__Output                              # }
                                                   # 
                                                   # 
