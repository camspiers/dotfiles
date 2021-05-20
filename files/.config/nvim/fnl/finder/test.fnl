(module finder.test {autoload {finder finder core aniseed.core}})

(fn score-compare [a b]
  (> a.score b.score))

(fn run-test [x size fnc]
  (collectgarbage)
  (let [times []]
    (for [_ 1 x]
      (let [tbl []]
        (for [i 1 size]
          (table.insert tbl {:score (math.random)}))
        (let [start (os.clock)]
          (fnc tbl)
          (table.insert times (* (- (os.clock) start) 1000)))))
    (print (string.format "Average time: %.2fms over %s runs for size %s"
                          (/ (core.reduce #(+ $1 $2) 0 times) x) x size))))

(run-test 100 100 (fn [tbl]
                    (finder.partial-quicksort tbl 1 (length tbl) 73
                                              score-compare)))

(run-test 100 1000
          (fn [tbl]
            (finder.partial-quicksort tbl 1 (length tbl) 73 score-compare)))

(run-test 100 10000
          (fn [tbl]
            (finder.partial-quicksort tbl 1 (length tbl) 73 score-compare)))

(run-test 100 100000
          (fn [tbl]
            (finder.partial-quicksort tbl 1 (length tbl) 73 score-compare)))

(run-test 100 100 (fn [tbl]
                    (table.sort tbl score-compare)))

(run-test 100 1000 (fn [tbl]
                     (table.sort tbl score-compare)))

(run-test 100 10000 (fn [tbl]
                      (table.sort tbl score-compare)))

(run-test 100 100000 (fn [tbl]
                       (table.sort tbl score-compare)))

