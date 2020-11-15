#!/usr/bin/python

import sys
from bs4 import BeautifulSoup
import re


def make_soup(content):
    soup = BeautifulSoup(content, 'html.parser')
    return soup


class ParseContent:
    __lnk_cnt = 0

    def __init__(self):
        print('Inside Parsing Class now!')

    @classmethod
    def get_a_tag_http_ref(cls, content):
        _cnt = 0
        print('get_a_tag_http_reg')
        soup = make_soup(content)
        lnk_list = []
        for lnk in soup.findAll('a', href=True):
            if re.match("(http)", lnk['href']):
                lnk_list.append(lnk['href'])
                _cnt = _cnt + 1
        cls.__lnk_cnt = _cnt
        return lnk_list

    @classmethod
    def get_title_tag(cls, content):
        print('get_title_tag')
        soup = make_soup(content)
        title_list = []
        for item in soup.find_all('title'):
            title_list.append(item.text)
        return title_list

    def get_lnk_cnt(self):
        return self.__lnk_cnt
