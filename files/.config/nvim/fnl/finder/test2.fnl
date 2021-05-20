(module finder.test2 {autoload {finder finder core aniseed.core}})

(fn score-compare [a b]
  (> a.score b.score))

(let [tbl1 []
      tbl2 []
      window-size 100
      table-size 100000]
  (for [i 1 table-size]
    (let [score (math.random)]
      (table.insert tbl1 {: score})
      (table.insert tbl2 {: score})))
  (finder.partial-quicksort tbl1 1 (length tbl1) window-size score-compare)
  (table.sort tbl2 score-compare)
  (each [index {: score} (ipairs tbl2)]
    (when (<= index window-size)
      (assert (= (. (. tbl1 index) :score) score)))))

