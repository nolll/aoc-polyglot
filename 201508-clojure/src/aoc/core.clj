(ns aoc.core
  (:gen-class))

(defn read-input
  []
  (
    slurp (
      .getFile (clojure.java.io/resource "input.txt")
    )
  )
)

(defn remove-quotes
  [s]
  (
    clojure.string/replace s "\\\"" "-"
  )
)

(defn remove-backslashes
  [s]
  (
    clojure.string/replace s "\\\\" "-"
  )
)

(defn remove-ascii
  [s]
  (
    clojure.string/replace s #"\\x.." "-"
  )
)

(defn count-code
  [s]
  (count s)
)

(defn count-memory
  [s]
  (
    count(
      remove-ascii (
        remove-backslashes (
          remove-quotes (
            subs s 1 (
              - (count s) 1
            )
          )
        )
      )
    )
  )
)

(defn count-encoded
  [s]
  (
    + 2 (
      count (
        clojure.string/replace (
          clojure.string/replace s "\\" "\\\\"
        ) "\"" "\\\""
      )
    )
  )
)

(defn -main
  [& args]
  (
    let [
      rows (clojure.string/split-lines (read-input))
      code-count (reduce + (map count-code rows))
      memory-count (reduce + (map count-memory rows))
      encoded-count (reduce + (map count-encoded rows))
    ]
    (
      println (- code-count memory-count)
    )
    (
      println (- encoded-count code-count)
    )
  )
)

