#!/bin/bash

# it has the following capabilities
# 1. [esc] to cancel search without navigating to home dir
# 2. -f to search for files and navigate to directory containing file
# 3. ability to pre-provide a search terms before entering fzf

# TODO ability to provide multiple search terms 
# TODO enforce flags must occur before search arguments


###########################
# copy the function below #
###########################

f() {
        search_type='d' # defaults to directory
        arg='' # defaults to all
        while [ $# -gt 0 ]; do
                if [ $1 == "-f" ]; then
                        search_type='f'
                else
                        arg+=$1
                fi
                shift
        done

        if [ $search_type == 'f' ]; then
                dirname=$(find * -type $search_type \
                                        ! -name '.git' \
                                        ! -name 'node_modules' \
                                | fzf --query="$arg" \
                                | xargs dirname) || return

        else
                dirname=$(find * -type $search_type \
                                        ! -name '.git'\
                                        ! -name 'node_modules' \
                                | fzf --query="$arg" ) || return
        fi
        cd $dirname
}

######################
# end function block #
######################