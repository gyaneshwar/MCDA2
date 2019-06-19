# -*- coding: utf-8 -*-
"""
Created on Mon Jun  3 17:56:56 2019

@author: gyane
"""

import pandas as pd

sample_df = pd.DataFrame({"a":[1,2,3], "b":[33,44,55]})

df = pd.read_csv('data/titles.csv')

print(len(df))
print(df.shape[0])

df.sort_values('year').head(10)

print(len(df[df.title == "Hamlet"]))

print(len(df[df.year == 1950]))
print(len(df[(df.year > 1950) & (df.year < 1989)]))

type(df.title.value_counts())#this gives type series.

df.title.value_counts().head(10)

#df.sort_values(by = 'title',ascending = False).value_counts().head(10)
((df.year//10)*10).value_counts()
((df.year//10)*10).value_counts().plot(kind="bar")

x = df[df.title == "Hamlet"]

((x.year//10)*10).value_counts()

titles_without_years = df.drop(columns=['year'])

df.drop(columns=['year'])

