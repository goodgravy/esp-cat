# -*- coding: utf-8 -*-

from collections import namedtuple
import re

Features = namedtuple('Features', ['ue', 'ie', 'ion', 'trail_o', 'trail_e'])

class WordToFeatures(object):
    def features(self, word):
        return Features(
                ue=self.__count_ue(word),
                ie=self.__count_ie(word),
                ion=self.__count_ion(word),
                trail_o=self.__trail_o(word),
                trail_e=self.__trail_e(word),
                )

    def __count_ue(self, word):
        return len(re.findall("ue", word))

    def __count_ie(self, word):
        return len(re.findall("ie", word))

    def __count_ion(self, word):
        return len(re.findall("ión\\Z", word))

    def __trail_o(self, word):
        return len(re.findall("o\\Z", word))

    def __trail_e(self, word):
        return len(re.findall("e\\Z", word))
