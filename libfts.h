/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libfts.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             */
/*   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBFTASM_LIBFTS_H
# define LIBFTASM_LIBFTS_H

/*
** PART 1
*/
void				ft_bzero	(void *s, size_t n);
int					ft_isalpha	(int c);
int					ft_isdigit	(int c);
int					ft_isalnum	(int c);
int					ft_isascii	(int c);
int					ft_print	(int c);
int					ft_toupper	(int c);
int					ft_tolower	(int c);
int					ft_puts		(char *const str);
char				*ft_strcat	(char *s1, const char *s2);

/*
** PART 2
*/
void				*ft_memset	(void *b, int c, size_t len);
void				*ft_memcpy	(void *s1, const void *s2, size_t n);
size_t				ft_strlen	(char *str);
char				*ft_strdup	(const char *s1);

/*
** PART 3
*/
int					ft_cat		(int fd);
#endif
