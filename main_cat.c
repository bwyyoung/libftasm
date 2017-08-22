/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_cat.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             */
/*   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include "libfts.h"

#undef KO
#undef OK
#define KO "\x1B[1;31mKO\033[0m"
#define OK "\x1B[1;34mOK\033[0m"
#undef TRUE
#undef FALSE
#define TRUE 1
#define FALSE 0
#undef DEBUG
#define DEBUG 0
typedef unsigned char t_bool;

t_bool	test_cat(t_bool debug)
{
#undef BUFF_SIZE
#define BUFF_SIZE 10000
	t_bool	ret = TRUE;
	t_bool	test = TRUE;
	char	buff1[BUFF_SIZE + 1] = {0};
	char	buff2[BUFF_SIZE + 1] = {0};
	int		out_pipe[2];
	int		saved_stdout;
	pid_t	father;
	int		fd;
	char	*files[] = {
			"./src/ft_bzero.s",
			"./src/ft_strcmp.s",
			"./src/ft_memset.s",
			"./Makefile",
			"./auteur"
	};

	char cmd[] = "cat";

	for (size_t pos = 0; pos < (sizeof(files) / sizeof(char*)); pos++)
	{
		char *args[] = {"cat", files[pos], NULL};

		//TEST 1
		bzero(buff1, BUFF_SIZE);
		saved_stdout = dup(STDOUT_FILENO);
		if(pipe(out_pipe) != 0) {
			exit(1);
		}
		dup2(out_pipe[1], STDOUT_FILENO);
		close(out_pipe[1]);

		//CAT CMD//
		father = fork();
		if (father > 0)
			wait(0);
		else if (father == 0)
		{
			if (execvp(cmd, args) == -1)
				puts("Exec format error.\n");
			exit(0);
		}

		fflush(stdout);
		read(out_pipe[0], buff1, BUFF_SIZE);

		//TEST 2
		bzero(buff2, BUFF_SIZE);
		if(pipe(out_pipe) != 0) {
			exit(1);
		}
		dup2(out_pipe[1], STDOUT_FILENO);
		close(out_pipe[1]);
		//FT_CAT CMD//
		fd = open(files[pos], O_RDONLY);
		ft_cat(fd); //FT_CAT CMD//
		close(fd);

		fflush(stdout);
		read(out_pipe[0], buff2, BUFF_SIZE);

		//AFF
		dup2(saved_stdout, STDOUT_FILENO);

		test = TRUE;
		if (memcmp(buff1, buff2, BUFF_SIZE) != 0)
		{
			ret = FALSE;
			test = FALSE;
		}
		if (debug)
		{
			printf("->%s\n", files[pos]);
			printf("[%s]\n", test ? OK : KO);

			printf("\x1B[1;37mCat:\033[0m\n");
			//CAT CMD//
			father = fork();
			if (father > 0)
				wait(0);
			else if (father == 0)
			{
				if (execvp(cmd, args) == -1)
					puts("Exec format error.\n");
				exit(0);
			}
			//FT_CAT CMD//
			printf("\n\x1B[1;37mft_cat:\033[0m\n");
			fd = open(files[pos], O_RDONLY);
			ft_cat(fd); //FT_CAT CMD//
			close(fd);
		}
	}
	return (ret);
}

t_bool	test_cat_fd_0(t_bool debug)
{
	t_bool	ret = TRUE;
	pid_t	father;

	(void)debug;

	//TEST FD 0//
	//CAT CMD//
	printf("\n\x1B[1;37mcat:\033[0m\n");

	char cmd[] = "cat";
	char *args[] = {"cat", NULL};

	father = fork();
	if (father > 0)
		wait(0);
	else if (father == 0)
	{
		if (execvp(cmd, args) == -1)
			puts("Exec format error.\n");
		exit(0);
	}

	//FT_CAT CMD//
	printf("\n\x1B[1;37mft_cat:\033[0m\n");
	ft_cat(0); //FT_CAT CMD//
	return (ret);
}

t_bool	test_cat_fd_test(t_bool debug)
{
	t_bool	ret = TRUE;
	(void)debug;

	//printf("\n\x1B[1;37mTest cat:\033[0m\n");
	ft_cat(0);
	ft_cat(open(__FILE__, O_RDONLY));
	ft_cat(open("test", O_RDONLY));
	ft_cat(-42);

	return (ret);
}

int main(int ac, char **av)
{
	int ret = 0;

	if (ac == 1) {
		ft_cat(0);
		ft_cat(open(__FILE__, O_RDONLY));
		ft_cat(open(av[0], O_RDONLY));
		ft_cat(-42);
	}
	else if (ac == 2) {
		int fd = open(av[1], O_RDONLY);
		ret = ft_cat(fd);
		if (fd != -1) {
			close(fd);
		} else {
			printf("error\n");
		}
	}
	else {
		printf("usage: %s [file]\n", av[0]);
	}
	return (ret);
}
