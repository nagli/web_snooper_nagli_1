#!/usr/bin/python

import sys
from Classes.RunURL import RunURL
from Classes.ParseContent import ParseContent


class RunApp:
    def __init__(self):
        print('RunApp class initialize')

    @staticmethod
    def run_app(start_page):
        ru = RunURL()
        ru_result = ru.run_url(start_page)
        if not ru_result:
            print('Error: Resolve URL: {} | Response: {}'.format(start_page, ru_result))
            sys.exit()

        _page_encoding = ru.get_page_encoding()
        _page_elapsed = ru.get_page_elapsed()
        _page_history = ru.get_page_history()
        _page_status = ru.get_page_status()
        _page_url = ru.get_page_url()
        _page_header = ru.get_page_header()
        _page_content = ru.get_page_content()

        # Debug print out
        print('Site Encoding: {}'.format(_page_encoding))
        print('Site Response time: {}'.format(_page_elapsed))
        print('Site History: {}'.format(_page_history))
        print('Site Status: {}'.format(_page_status))
        print('Site Url: {}'.format(_page_url))
        print('Site Header: {}'.format(_page_header))
        # print(f'Site Content: {_page_content}')

        # next parse the content for href attribute from <a/> tag
        par_cont = ParseContent()
        title_list = par_cont.get_title_tag(_page_content)
        print('All title tags %s' % title_list)
        lnk_list = par_cont.get_a_tag_http_ref(_page_content)
        if len(lnk_list) == 0:
            sys.exit('Did not get any links from the parses page, No reason to continue')
        for item in lnk_list:
            print("links: %s" % item)

        print("#links found: %d" % par_cont.get_lnk_cnt())
