import pandas as pd

# %% read file into a df
t = pd.DataFrame.from_csv("data/titles.csv", index_col=None)

# %% print sample head and tail

print(t.head())
print(t.tail())

# %% How many movies are listed in the titles dataframe?
print(len(t))

# %% What are the earliest two films listed in the titles dataframe?
print(t.sort_values('year').head(2))

# %% How many movies have the title "Hamlet"?
no_of_hamlets = len(t[t.title =="Hamlet"])
print(no_of_hamlets)

# %% How many movies were made in the year 1950?
print(len(t[t.year==1950]))

# %% How many movies were made from 1950 through 1959?
print(len(t[(t.year>=1950) & (t.year<=1959)]))
print(len(t[t.year//10==195]))

# %% What are the ten most common movie names of all time?
print(t.title.value_counts().head(10))

# %% Plot the number of films that have been released each decade
# over the history of cinema.
(t.year // 10 * 10).value_counts().sort_index().plot(kind='bar')


# %% Plot the number of "Hamlet" films made each decade.
h = t[t.title=="Hamlet"]
(h.year //10*10).value_counts().sort_index().plot(kind='bar')
