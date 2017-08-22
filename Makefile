# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2014/09/09 10:19:19 by byoung-w          #+#    #+#              #
#    Updated: 2015/04/29 20:13:26 by byoung-w         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #



NAME			= libfts.a
TEST			= test
TEST_CAT		= cat
QPEREZ			= qperez

CC				= gcc
CC_ASM			= nasm   # ~/usr/local/bin/nasm --> personal BREW NASM
FLAG			= -Wall -Werror -Wextra -pedantic -Wimplicit-function-declaration
INCS			= -I ./
LIBS			=

DIR_SRC_P1		= asm/p1
DIR_SRC_P2		= asm/p2
DIR_SRC_P3		= asm/p3


DIR_INC			= .

SRC				= $(DIR_SRC_P1)/ft_bzero.s \
				$(DIR_SRC_P1)/ft_isalnum.s \
				$(DIR_SRC_P1)/ft_isalpha.s \
				$(DIR_SRC_P1)/ft_isascii.s \
				$(DIR_SRC_P1)/ft_isdigit.s \
				$(DIR_SRC_P1)/ft_isprint.s \
				$(DIR_SRC_P1)/ft_strcat.s \
				$(DIR_SRC_P1)/ft_puts.s \
				$(DIR_SRC_P1)/ft_toupper.s \
				$(DIR_SRC_P1)/ft_tolower.s \
				$(DIR_SRC_P2)/ft_strlen.s \
				$(DIR_SRC_P2)/ft_memset.s \
				$(DIR_SRC_P2)/ft_memcpy.s \
				$(DIR_SRC_P2)/ft_strdup.s \
				$(DIR_SRC_P3)/ft_cat_3.s \
				$(DIR_SRC_P3)/ft_puth.s \
				$(DIR_SRC_P3)/ft_exit.s

DIR_LIST		= asm $(DIR_SRC_P1) $(DIR_SRC_P2) $(DIR_SRC_P3)

DIR_OBJ_ASM		= .obj

$(DIR_OBJ_ASM) :
	@/bin/mkdir $(DIR_OBJ_ASM); \
		for DIR in $(DIR_LIST); \
		do \
			/bin/mkdir $(DIR_OBJ_ASM)/$$DIR; \
		done

OBJ_ASM			= $(addprefix $(DIR_OBJ_ASM)/, $(SRC:.s=.o))
OBJ				= $(addprefix $(DIR_OBJ)/, $(SRC:.c=.o))

$(DIR_OBJ) :
	@/bin/mkdir $(DIR_OBJ); \

all : $(NAME)

$(NAME):
	@if ! [ -a '$(NAME)' ]; then \
		make runmake; \
	fi

runmake : $(DIR_OBJ_ASM) $(OBJ_ASM)
	@ar rc $(NAME) $(OBJ_ASM)
	@ranlib $(NAME)
	@printf "\e[32m------------------------------------------------------\e[0m\n"
	@printf '\e[34m%-51s\e[0m\e[32m[✔]\e[0m\n' "created libfts.a"
	@printf "\e[32m------------------------------------------------------\e[0m\n"

$(addprefix $(DIR_OBJ_ASM)/, %.o) : %.s $(DIR_INC)
	@printf "compiling \e[33m%-41s\e[0m" "$@"
	@$(CC_ASM) -f macho64 -o $@ $<
	@printf "\e[32m[✔]\e[0m\n"

clean :
	@if [ -e '$(DIR_OBJ_ASM)' ]; then \
		/bin/rm	-rf $(DIR_OBJ); \
		/bin/rm	-rf $(DIR_OBJ_ASM); \
		printf "\e[32m[✔]\e[0m project %s cleaned.\n" $(NAME); \
		fi

fclean : clean
	@if [ -e '$(NAME)' ]; then \
		/bin/rm -f $(NAME); \
		/bin/rm -f $(TEST); \
		/bin/rm -f $(TEST_CAT); \
		/bin/rm -f $(QPEREZ); \
		printf "\e[32m[✔]\e[0m project %s fcleaned.\n" $(NAME); \
		fi

re : fclean all

$(TEST): $(NAME) main.c
	@$(CC) $(INCS) -L . -lfts main.c -o $@
	@printf "\e[32m------------------------------------------------------\e[0m\n"
	@printf '\e[34m%-51s\e[0m\e[32m[✔]\e[0m\n' "created test"
	@printf "\e[32m------------------------------------------------------\e[0m\n"

$(TEST_CAT): $(NAME) main_cat.c
	@$(CC) $(INCS) -L . -lfts main_cat.c -o $@
	@printf "\e[32m------------------------------------------------------\e[0m\n"
	@printf '\e[34m%-51s\e[0m\e[32m[✔]\e[0m\n' "created cat"
	@printf "\e[32m------------------------------------------------------\e[0m\n"

$(QPEREZ): $(NAME) main_qperez.c
	@$(CC) $(INCS) -L . -lfts main_qperez.c -o $@
	@printf "\e[32m------------------------------------------------------\e[0m\n"
	@printf '\e[34m%-51s\e[0m\e[32m[✔]\e[0m\n' "created qperez"
	@printf "\e[32m------------------------------------------------------\e[0m\n"

.PHONY:	clean fclean re