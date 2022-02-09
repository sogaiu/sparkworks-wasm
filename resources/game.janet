#(import jaylib :as j)
(use ./utils)
(use ./assets)
(use ./tilemap)
(use ./player)
(import ./start-menu)
(import ./level1)

(var- state nil)

(defn switch-state [new-state]
  # XXX
  #(when-let [music (dyn :music)]
  # XXX
  #  (pause-music-stream music))
  (set state new-state))

(defn run-game [assets] 
  (put assets :start-menu/init start-menu/init)
  (put assets :level1/init level1/init)
  (setdyn :assets assets)
  (set state (start-menu/init assets))
  (math/seedrandom (os/time))
  (while (not (window-should-close))
    (:update state (get-frame-time) switch-state)
    (begin-drawing)
    (:draw state)
    (end-drawing))
  (close-window)
  (cleanup-assets))

(defn update-draw-frame
  []
  (:update state (get-frame-time) switch-state)
  (begin-drawing)
  (:draw state)
  (end-drawing))

(defn start-game [assets] 
  (put assets :start-menu/init start-menu/init)
  (put assets :level1/init level1/init)
  # XXX
  #(setdyn :assets assets)
  (put root-env :assets assets)
  (set state (start-menu/init assets))
  (math/seedrandom (os/time)))

'(defn main [& args]
  (set-trace-log-level :error)
  (init-window 1200 800 "Spark works")
  (init-audio-device)
  (set-target-fps 60)
  (hide-cursor)
  (def assets (load-assets)) 
  (run-game assets))

# XXX
(set-trace-log-level :error)
(init-window 1200 800 "Spark works")
#(init-audio-device)
#(set-target-fps 60)
(hide-cursor)
(def assets (load-assets)) 
(put assets :start-menu/init start-menu/init)
(put assets :level1/init level1/init)
(setdyn :assets assets)
(set state (start-menu/init assets))

(def main-fiber
  (fiber/new
    (fn []
      (math/seedrandom (os/time))
      (while (not (window-should-close))
        (:update state (get-frame-time) switch-state)
        (begin-drawing)
        (:draw state)
        (end-drawing)
        (yield))
      (close-window)
      (cleanup-assets))
    :i))
  
