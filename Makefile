NAME = libmlx.a


CC = x86_64-w64-mingw32-gcc.exe
CFLAGS = -Wall -Wextra -g3


MAKE = mingw32-make.exe

SDL_DIR = ./SDL
SDL_INCLUDE_DIR = $(SDL_DIR)/include/SDL2

INCLUDES_DIR = ./includes
INCLUDES = -I$(INCLUDES_DIR) -I$(SDL_INCLUDE_DIR)
HEADERS = $(addprefix $(INCLUDES_DIR)/, mlx_int.h linked_lists.h)

SRC_DIR = ./srcs
SRC = $(addprefix $(SRC_DIR)/, mlx.c \
linked_lists/ft_lstadd_back.c \
linked_lists/ft_lstadd_front.c \
linked_lists/ft_lstclear.c \
linked_lists/ft_lstcpy.c \
linked_lists/ft_lstdelone.c \
linked_lists/ft_lstiter.c \
linked_lists/ft_lstlast.c \
linked_lists/ft_lstmap.c \
linked_lists/ft_lstnew.c \
linked_lists/ft_lstsize.c \
linked_lists/ft_lstchr.c)

OBJDIR = obj
OBJ = $(SRC:$(SRC_DIR)/%.c= $(OBJDIR)/%.o)
OBJ_PATHS = $(shell ls -R $(SRC_DIR) | grep / | sed 's/://g' | sed 's/srcs/$(OBJDIR)/g')

LINKS = -L"$(SDL_DIR)/lib" -lmingw32 -lSDL2main -lSDL2 -lSDL2_image -lSDL2_mixer \
-lSDL2_ttf  -lmingw32 -lSDL2main -lSDL2.dll -luser32 -lgdi32 -lwinmm -ldxguid \
"$(SDL_DIR)/lib/libSDL2.a" "$(SDL_DIR)/lib/libSDL2.dll.a" \
"$(SDL_DIR)/lib/libSDL2_image.a" "$(SDL_DIR)/lib/libSDL2_image.dll.a" \
"$(SDL_DIR)/lib/libSDL2_mixer.a" "$(SDL_DIR)/lib/libSDL2_mixer.dll.a" \
"$(SDL_DIR)/lib/libSDL2_test.a" "$(SDL_DIR)/lib/libSDL2_ttf.a" \
"$(SDL_DIR)/lib/libSDL2_ttf.dll.a"

all: $(NAME) $(HEADERS)

$(NAME): $(OBJ)
	ar rcs $(NAME) $(OBJ)
	$(MAKE) all -C test

$(OBJDIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	@mkdir -p $(OBJ_PATHS)
	$(CC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

clean:
	$(RM) $(OBJ) $(OBJBONUS)

fclean: clean
	$(RM) $(NAME)

re: fclean all	

.PHONY: clean fclean