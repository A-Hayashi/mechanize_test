require "./test"

IMG_SEL_FILE = "./img_select.txt"
                                                                                                              
guard :shell do                                                                                               
  watch(IMG_SEL_FILE) do |m|
	arr = Gazo.img_file(IMG_SEL_FILE)
	Gazo.multi_upload(arr)
  end             
end     