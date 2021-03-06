(use ./utils)
(import ./button)
(import ./label)
#(import jaylib :as j)
(import ./menu)
(import ./level1)
(import ./credits)
(import ./tutorial)
(import ./assets)

(defn start-game [state switch]
  (switch (level1/init (state :assets))))

(defn exit-game [&]
  (close-window)
  (assets/cleanup-assets))

(defn show-credits [state switch]
  (switch (credits/init (state :assets))))

(defn show-tutorial [state switch]
  (switch (tutorial/init (state :assets))))

(defn init [assets]
  (var ytrack 80)
  (var xtrack 300)
  (def state {:assets assets})
  (def menu 
    (menu/init 
      assets 
      [(label/init "Sparkworks" [xtrack (+= ytrack 40)] 100 [1 1 0])

       (button/init "Start Game" [(+= xtrack 60) (+= ytrack 140)] 80 [1 1 1] 
                    (fn [me switch] (start-game state switch)))

       (button/init "Credits" [xtrack (+= ytrack 90)] 80 [1 1 1] 
                    (fn [me switch] (show-credits state switch)))

       (button/init "Tutorial" [xtrack (+= ytrack 90)] 80 [1 1 1] 
                    (fn [me switch] (show-tutorial state switch)))

       (button/init "Exit" [xtrack (+= ytrack 90)] 80 [1 1 1] 
                    (fn [me switch] (exit-game))) ] 
      {:clear [0 0 0]}))
  (put menu :shown true)
  menu)
