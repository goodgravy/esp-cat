# -*- coding: utf-8 -*-

import pytest

from .context import translate

@pytest.fixture
def word_to_features():
    return translate.word_to_features.WordToFeatures()

def test_ue(word_to_features):
    assert word_to_features.features("puerilepuerh").ue == 2
    assert word_to_features.features("cheese").ue == 0

def test_ie(word_to_features):
    assert word_to_features.features("fiercefierydiet").ie == 3
    assert word_to_features.features("chips").ie == 0

def test_ion(word_to_features):
    assert word_to_features.features("manifestación").ion == 1
    assert word_to_features.features("apples").ion == 0

def test_trail_o(word_to_features):
    assert word_to_features.features("arco").trail_o == 1
    assert word_to_features.features("hats").trail_o == 0

def test_trail_e(word_to_features):
    assert word_to_features.features("esmalte").trail_e == 1
    assert word_to_features.features("bunnies").trail_e == 0
