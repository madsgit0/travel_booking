from PIL import Image, ImageDraw

def create_circle_favicon(size, color, output_path):
    image = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    draw.ellipse((0, 0, size, size), fill=color)
    image.save(output_path, "PNG")

if __name__ == "__main__":
    create_circle_favicon(192, "#FE7F2D", "web/favicon.png")
    print("Favicon generated successfully.")
