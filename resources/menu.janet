(use ./utils)
(import ./button)
#(import jaylib :as j)

(defn- update-menu [state dt switch-state]
  (def mpos (get-mouse-position))
  (def key (state :toggle-key))
  (when (and key (key-pressed? key))
    (put state :shown (not (state :shown))))

  (when (state :shown) 
    (def {:state { :menu-entries menu }} state)
    (each entry menu (:update entry state dt mpos switch-state))))

(defn- draw-menu 
  [{:clear clear :state state :shown shown :cursor cursor}]
  (def [mx my] (get-mouse-position))
  (when clear 
    (clear-background clear))
  (when state
    (each entry (state :menu-entries) 
      (:draw entry)))
  (when clear
    (:draw cursor mx my)))

(defn init [assets entries &opt options]
  (def state 
    @{:update update-menu
      :draw draw-menu
      :shown false
      :clear (get options :clear)
      :toggle-key (get options :toggle-key)
      :cursor (assets :cursor)
      :assets assets})
   (def menu-state 
     @{ :menu-entries  entries })
   (put state :state menu-state))
