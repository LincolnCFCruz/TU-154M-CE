
-- button is clickable area with texture

defineProperty("image")

-- function
defineProperty("action")

components = {

    texture { image = image };

    clickable {
        cursor = { 
            x = 8, 
            y = 26, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },
    };
}

