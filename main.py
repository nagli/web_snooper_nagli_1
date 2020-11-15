#!/usr/bin/python

import sys
import getopt
from Classes.RunApp import RunApp


def main(argv):
    help_text = 'use this syntax: main.py -s <page url> OR main.py --start_page=<page url>'
    start_page = ''
    # get the start page from the passed arguments, if not start page passed, end application and return user msg.
    try:
        opts, args = getopt.getopt(argv, "hs:", ['start_page='])
    except getopt.GetoptError:
        print('error: ' + help_text)
        sys.exit('failed receiving arguments correctly')

    for opt, arg in opts:
        if opt == '-h':
            print('help: ' + help_text)
            sys.exit('Support Request')
        # elif opt in ('-l', '--limit'):
        #    limit = arg
        elif opt in ('-s', '--start_page'):
            start_page = arg
    print('The selected start page is: %s' % start_page)

    ru_app = RunApp()
    # check if limit is set
    # if start page is set, ignore limit

    ru_app_result = ru_app.run_app(start_page)

    print('The run returns: %s' % ru_app_result)

    sys.exit('End of script')


if __name__ == "__main__":
    main(sys.argv[1:])
