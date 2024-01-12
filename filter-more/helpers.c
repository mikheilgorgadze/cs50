#include "helpers.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>



typedef enum Position{
    TOP_LEFT,
    TOP_RIGHT,
    BOTTOM_LEFT,
    BOTTOM_RIGHT,
    TOP,
    BOTTOM,
    RIGHT,
    LEFT
} Position;

typedef struct PixelInfo{
    bool isCorner;
    bool isEdge;
    Position position;
}  PixelInfo;


unsigned int avg_pixels(unsigned int *colors, int color_count); 
unsigned int pixel_to_hex(RGBTRIPLE pixel); 
PixelInfo get_pixel_info(int x_pos, int y_pos, int height, int width);

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            BYTE red = image[i][j].rgbtRed;
            BYTE green = image[i][j].rgbtGreen;
            BYTE blue = image[i][j].rgbtBlue;
            
            float avg_pixel_float = (1.0 * red + 1.0 * green + 1.0 * blue) / 3;
            BYTE avg_pixel = round(avg_pixel_float);

            image[i][j].rgbtRed = avg_pixel;
            image[i][j].rgbtGreen = avg_pixel;
            image[i][j].rgbtBlue = avg_pixel;

        }
    }

    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++){
        for (int j = 0; j < width; j++){
            if (j <= width - 1 - j) {
                RGBTRIPLE temp;
                temp = image[i][j];
                image[i][j] = image[i][width - 1 - j];
                image[i][width - 1- j] = temp;
            }
           
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp[height][width];

    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
           PixelInfo pixel_info= get_pixel_info(x, y, height, width);

           int bottom_ind  = y + 1;
           int top_ind = y - 1;
           int left_ind  = x - 1;
           int right_ind = x + 1;

           unsigned int average_pixel_color = 0;
           if (pixel_info.isCorner) {

                if (y == 0 && x == 0) {
                    unsigned int pixels[] = {
                        pixel_to_hex(image[y][x]), 
                        pixel_to_hex(image[y][right_ind]),
                        pixel_to_hex(image[bottom_ind][x]),
                        pixel_to_hex(image[bottom_ind][right_ind])
                    };

                    int color_count = sizeof(pixels) / sizeof(pixels[0]);
                    average_pixel_color = avg_pixels(pixels, color_count);
                } else if (y == 0 && x == width - 1) {
                    
                    unsigned int pixels[] = {
                        pixel_to_hex(image[y][x]), 
                        pixel_to_hex(image[y][left_ind]),
                        pixel_to_hex(image[bottom_ind][x]),
                        pixel_to_hex(image[bottom_ind][left_ind])
                    };

                    int color_count = sizeof(pixels) / sizeof(pixels[0]);
                    average_pixel_color = avg_pixels(pixels, color_count);

                } else if (y == height - 1 && x == 0) {
                    
                    unsigned int pixels[] = {
                        pixel_to_hex(image[y][x]), 
                        pixel_to_hex(image[y][right_ind]),
                        pixel_to_hex(image[top_ind][x]),
                        pixel_to_hex(image[top_ind][right_ind])
                    };

                    int color_count = sizeof(pixels) / sizeof(pixels[0]);
                    average_pixel_color = avg_pixels(pixels, color_count);
                }else if (y == height - 1 && x == width - 1) {
                    
                    unsigned int pixels[] = {
                        pixel_to_hex(image[y][x]), 
                        pixel_to_hex(image[y][left_ind]),
                        pixel_to_hex(image[top_ind][x]),
                        pixel_to_hex(image[top_ind][left_ind])
                    };

                    int color_count = sizeof(pixels) / sizeof(pixels[0]);
                    average_pixel_color = avg_pixels(pixels, color_count);
                }

           } 
           if (pixel_info.isEdge) {
                if (pixel_info.position == RIGHT) {
                    
                    unsigned int pixels[] = {
                        pixel_to_hex(image[y][x]), 
                        pixel_to_hex(image[top_ind][x]),
                        pixel_to_hex(image[bottom_ind][x]),
                        pixel_to_hex(image[y][left_ind]),
                        pixel_to_hex(image[top_ind][left_ind]),
                        pixel_to_hex(image[bottom_ind][left_ind])
                    };

                    int color_count = sizeof(pixels) / sizeof(pixels[0]);
                    average_pixel_color = avg_pixels(pixels, color_count);

                } else if (pixel_info.position == LEFT) {
                
                    unsigned int pixels[] = {
                        pixel_to_hex(image[y][x]), 
                        pixel_to_hex(image[top_ind][x]),
                        pixel_to_hex(image[bottom_ind][x]),
                        pixel_to_hex(image[y][right_ind]),
                        pixel_to_hex(image[top_ind][right_ind]),
                        pixel_to_hex(image[bottom_ind][right_ind])
                    };

                    int color_count = sizeof(pixels) / sizeof(pixels[0]);
                    average_pixel_color = avg_pixels(pixels, color_count);
                } else if (pixel_info.position == TOP) {
                
                    unsigned int pixels[] = {
                        pixel_to_hex(image[y][x]), 
                        pixel_to_hex(image[y][left_ind]),
                        pixel_to_hex(image[y][right_ind]),
                        pixel_to_hex(image[bottom_ind][x]),
                        pixel_to_hex(image[bottom_ind][left_ind]),
                        pixel_to_hex(image[bottom_ind][right_ind])
                    };

                    int color_count = sizeof(pixels) / sizeof(pixels[0]);
                    average_pixel_color = avg_pixels(pixels, color_count);
                } else if (pixel_info.position == BOTTOM) {
                
                    unsigned int pixels[] = {
                        pixel_to_hex(image[y][x]), 
                        pixel_to_hex(image[y][left_ind]),
                        pixel_to_hex(image[y][right_ind]),
                        pixel_to_hex(image[top_ind][x]),
                        pixel_to_hex(image[top_ind][left_ind]),
                        pixel_to_hex(image[top_ind][right_ind])
                    };

                    int color_count = sizeof(pixels) / sizeof(pixels[0]);
                    average_pixel_color = avg_pixels(pixels, color_count);
                }
           
           } 
           if (!pixel_info.isCorner && !pixel_info.isEdge) {
                
               unsigned int pixels[] = {
                   pixel_to_hex(image[y][x]), 
                   pixel_to_hex(image[y][left_ind]),
                   pixel_to_hex(image[y][right_ind]),
                   pixel_to_hex(image[top_ind][x]),
                   pixel_to_hex(image[bottom_ind][x]),
                   pixel_to_hex(image[top_ind][left_ind]),
                   pixel_to_hex(image[top_ind][right_ind]),
                   pixel_to_hex(image[bottom_ind][left_ind]),
                   pixel_to_hex(image[bottom_ind][right_ind])
               };

               int color_count = sizeof(pixels) / sizeof(pixels[0]);
               average_pixel_color = avg_pixels(pixels, color_count);

           }

           BYTE red = (average_pixel_color >> 16) & 0xFF;
           BYTE green = (average_pixel_color >> 8) & 0xFF;
           BYTE blue = (average_pixel_color) & 0xFF;

           temp[y][x].rgbtRed = red;
           temp[y][x].rgbtGreen = green;
           temp[y][x].rgbtBlue = blue;
            
        }

    }

    for (int col = 0; col < height; col++) {
        for (int row = 0; row < width; row++) {
            image[col][row] = temp[col][row];
        }
    }

    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < height; x++) {

            
        }

    }
    return;
}



// additional functions
unsigned int pixel_to_hex(RGBTRIPLE pixel) {
    BYTE red = pixel.rgbtRed;
    BYTE green = pixel.rgbtGreen;
    BYTE blue = pixel.rgbtBlue;

    return (red << 16) | (green << 8) | blue;

}

unsigned int avg_pixels(unsigned int *colors, int color_count) {

    if (color_count <= 0) {
        return 0;
    }
    unsigned int total_red = 0, total_green = 0, total_blue = 0;

    for (int i = 0; i < color_count; i++) {
        unsigned int color = colors[i];
        total_red += (color >> 16) & 0xFF;
        total_green += (color >> 8) & 0xFF;
        total_blue += color & 0xFF;
    }
    float avg_red_f = 1.0 * total_red / color_count;
    unsigned int avg_red = round(avg_red_f);

    float avg_green_f = 1.0 * total_green / color_count;
    unsigned int avg_green = round(avg_green_f);

    float avg_blue_f = 1.0 * total_blue / color_count;
    unsigned int avg_blue = round(avg_blue_f);

    unsigned int avg_color = (avg_red << 16) | (avg_green << 8) | avg_blue;
    return avg_color;
}


PixelInfo get_pixel_info(int x_pos, int y_pos, int height, int width) {
    int x_pos_left = x_pos - 1;
    int x_pos_right = x_pos + 1;
    int y_pos_top = y_pos - 1;
    int y_pos_bottom = y_pos + 1;
    
    bool is_left   = x_pos_left < 0;
    bool is_right  = x_pos_right >= width;
    bool is_top    = y_pos_top < 0;
    bool is_bottom = y_pos_bottom >= height;

    PixelInfo corner;
    corner.isCorner = (is_left && is_top) ||
           (is_right && is_top)||
           (is_left && is_bottom)||
           (is_right && is_bottom);

    corner.isEdge = !corner.isCorner && (is_left || is_right || is_top || is_bottom);



    if (is_left && is_top) corner.position = TOP_LEFT;
    if (is_right && is_top) corner.position = TOP_RIGHT;
    if (is_left && is_bottom) corner.position = BOTTOM_LEFT;
    if (is_right && is_bottom) corner.position = BOTTOM_RIGHT;
    if (is_left && (!is_top || !is_bottom)) corner.position = LEFT;
    if (is_right && (!is_top || !is_bottom)) corner.position = RIGHT;
    if (is_bottom && (!is_left || !is_right)) corner.position = BOTTOM;
    if (is_top && (!is_left || !is_right)) corner.position = TOP;
    


    return corner;
}
