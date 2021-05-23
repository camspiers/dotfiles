(module snapcustom.config {autoload {astring aniseed.string core aniseed.core}})

;; The rg types to search on
(var types [])
(var globs [])

;; Allows for the registering of types that a project searches on
(defn settypes [t] (set types t))
(defn addtypes [t] (set types (core.concat types t)))

;; Alloes for the registering of globs to search on
(defn setglobs [g] (set globs g))
(defn addglobs [t] (set globs (core.concat globs t)))

(defn gettypes []
      (astring.join " " (core.map #(string.format "-t%s" $1) types)))

(defn getiglobs [] (astring.join " "
                                 (core.map #(string.format "--iglob '%s'" $1)
                                           globs)))

(defn getglobs [] (astring.join " "
                                (core.map #(string.format "--glob '%s'" $1)
                                          globs)))

