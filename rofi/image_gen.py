from PIL import Image, ImageDraw, ImageFont

# Load the provided image
image_path = "assets/wallbash_mode.png"
image = Image.open(image_path)

# Image size
width, height = image.size

# Create a new blank image with the same dimensions and transparency
new_image = Image.new("RGBA", (width, height), (0, 0, 0, 0))

# Draw on the new image
draw = ImageDraw.Draw(new_image)

# Define the new text and font
new_text = "POWERSAVER"

# Assuming the font size and color based on the provided image
font_size = 72
font = ImageFont.truetype("DejaVuSans.ttf", font_size)
text_color = (255, 255, 255, 255)

# Get text size
text_bbox = draw.textbbox((0, 0), new_text, font=font)
text_width = text_bbox[2] - text_bbox[0]
text_height = text_bbox[3] - text_bbox[1]

# Position the text in the same area as  the original
text_x = (width - text_width) // 2
text_y = height // 4

# Draw the text
draw.text((text_x, text_y), new_text, font=font, fill=text_color)

# Paste the new text onto the orginal image
result_image = Image.alpha_composite(image, new_image)

# Save the result
result_path = "assets/powersaver_mode.png"
result_image.save(result_path)

result_path
