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

(defn count-code
  [s]
  (count s)
)

(defn count-memory
  [s]
  (count s)
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
      codeCount (reduce + (map count-code rows))
      memoryCount (reduce + (map count-memory rows))
      encodedCount (reduce + (map count-encoded rows))
    ]
    (
      println codeCount
    )
    (
      println (- encodedCount codeCount)
    )
  )
)

