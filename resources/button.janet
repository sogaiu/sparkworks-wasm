#(import jaylib :as j)

(defn- hover-rect 
  [
   {:text text
    :coord [x y]
    :size h
    :color color }
   ] 
  (def text-width (measure-text text h))
  [x y (+ text-width 10) h])

(defn- update-menu-entry [entry menu dt [mx my] switch]
  (def 
    {:text text
    :coord [x y]
    :size h
    :color color} entry)
  (def hovered (check-collision-recs [mx my 1 1] (hover-rect entry)))
  (put entry :hovered hovered)
  (def clicked (and (mouse-button-pressed? :left) hovered))
  (when clicked
    (play-sound (entry :click-sound))
    ((entry :on-click) menu switch)))

(defn- draw-menu-entry [entry] 
  (def 
    {:text text
    :coord [x y]
    :size h
    :color color} entry)
  (def text-width (measure-text text h))

  (draw-text text (+ x 10) (+ y 4) (- h 3) color)
  (when (entry :hovered)
    (draw-rectangle-lines ;(hover-rect entry) color)))

(defn init [text coord size color on-click]
  (def assets (get root-env :assets))
  @{:text text
    :coord coord
    :size size
    :color color
    :click-sound (assets :click-sound)
    :hovered false
    :update update-menu-entry
    :draw draw-menu-entry
    :on-click on-click })
