Graphics.open_graph " 640x480";;

for i = 12 downto 1 do
  Graphics.draw_circle 320 240 (i*20)
done;;  

read_line();;