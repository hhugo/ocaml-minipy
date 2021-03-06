open! Base

type boolop =
  | And
  | Or
[@@deriving sexp]

type unaryop =
  | Invert
  | Not
  | UAdd
  | USub
[@@deriving sexp]

type operator =
  | Add
  | Sub
  | Mult
  | MatMult
  | Div
  | Mod
  | Pow
  | LShift
  | RShift
  | BitOr
  | BitXor
  | BitAnd
  | FloorDiv
[@@deriving sexp]

type cmpop =
  | Eq
  | NotEq
  | Lt
  | LtE
  | Gt
  | GtE
  | Is
  | IsNot
  | In
  | NotIn
[@@deriving sexp]

type stmt =
  | FunctionDef of
      { name : string
      ; args : arguments
      ; body : stmt list
      }
  | ClassDef of
      { name : string
      ; args : arguments
      ; body : stmt list
      }
  | If of
      { test : expr
      ; body : stmt list
      ; orelse : stmt list
      }
  | For of
      { target : expr
      ; iter : expr
      ; body : stmt list
      ; orelse : stmt list
      }
  | While of
      { test : expr
      ; body : stmt list
      ; orelse : stmt list
      }
  | Raise of
      { exc : expr option
      ; cause : expr option
      }
  | Try of
      { body : stmt list
      ; handlers : excepthandler list
      ; orelse : stmt list
      ; finalbody : stmt list
      }
  | Assert of
      { test : expr
      ; msg : expr option
      }
  | Expr of { value : expr }
  | Assign of
      { targets : expr list
      ; value : expr
      }
  | AugAssign of
      { target : expr
      ; op : operator
      ; value : expr
      }
  | Return of { value : expr option }
  | Delete of { targets : expr list }
  | Pass
  | Break
  | Continue

and expr =
  | None_
  | Bool of bool
  | Num of Z.t
  | Float of float
  | Str of string
  | Name of string
  | List of expr array
  | Dict of { key_values : (expr * expr) list }
  | ListComp of
      { elt : expr
      ; generators : comprehension list
      }
  | Tuple of expr array
  | Lambda of
      { args : arguments
      ; body : expr
      }
  | BoolOp of
      { op : boolop
      ; values : expr list
      }
  | BinOp of
      { left : expr
      ; op : operator
      ; right : expr
      }
  | UnaryOp of
      { op : unaryop
      ; operand : expr
      }
  | IfExp of
      { test : expr
      ; body : expr
      ; orelse : expr
      }
  | Compare of
      { left : expr
      ; ops : cmpop (* TODO: cmpop list *)
      ; comparators : expr (* TODO: expr list *)
      }
  | Call of
      { func : expr
      ; args : expr list
      ; keywords : (string * expr) list
      }
  | Attribute of
      { value : expr
      ; attr : string
      }
  | Subscript of
      { value : expr
      ; slice : expr
      }

and comprehension =
  { target : expr
  ; iter : expr
  ; ifs : expr list
  }

and arguments =
  { args : string list
  ; vararg : string option
  ; kwonlyargs : (string * expr) list
  ; kwarg : string option
  }

and excepthandler =
  { type_ : expr option
  ; name : string option
  ; body : stmt list
  }
[@@deriving sexp]

type t = stmt list [@@deriving sexp]
