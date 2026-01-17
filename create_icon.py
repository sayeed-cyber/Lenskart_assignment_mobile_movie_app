from PIL import Image, ImageDraw

# Create a 1024x1024 image with red background
size = 1024
img = Image.new('RGB', (size, size), color='#E50914')

# Save the icon
img.save('assets/icons/app_icon.png')

# Create foreground icon (white movie symbol on transparent)
foreground = Image.new('RGBA', (size, size), color=(0, 0, 0, 0))
draw = ImageDraw.Draw(foreground)

# Draw a simple movie/play icon
# Draw a rounded rectangle (simplified movie reel)
margin = 200
draw.rounded_rectangle(
    [margin, margin, size-margin, size-margin],
    radius=80,
    fill='white',
    outline='white',
    width=60
)

# Draw a play triangle in the center
center_x = size // 2
center_y = size // 2
triangle_size = 200
triangle = [
    (center_x - triangle_size//2, center_y - triangle_size),
    (center_x - triangle_size//2, center_y + triangle_size),
    (center_x + triangle_size, center_y)
]
draw.polygon(triangle, fill='#E50914')

foreground.save('assets/icons/app_icon_foreground.png')

print("Icons created successfully!")
print("- app_icon.png (main icon)")
print("- app_icon_foreground.png (adaptive icon foreground)")
