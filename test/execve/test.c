/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mdelage <mdelage@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2014/01/29 19:31:45 by mdelage           #+#    #+#             */
/*   Updated: 2014/01/29 19:39:20 by mdelage          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

int		main(int ac, char **av, char **env)
{
	char	*arg[3] = {"cat", "-e", "<tutu"};

	(void)ac;
	(void)av;
	execve("/bin/cat", arg, env);
	return (0);
}