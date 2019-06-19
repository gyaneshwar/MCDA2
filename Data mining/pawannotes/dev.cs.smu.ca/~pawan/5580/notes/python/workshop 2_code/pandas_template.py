import pandas as pd

# %% read file into a df

df = pd.read_csv("data/titles.csv")

# %% print sample head and tail
print(df.head(5))
print(df.tail(5))


# %% How many movies are listed in the titles dataframe?
print(len(df))

# %% What are the earliest two films listed in the titles dataframe?

print(df.sort_values('year').head(2))

# %% How many movies have the title "Hamlet"?
print(len(df[df.title=="Hamlet"]))

# %% How many movies were made in the year 1950?
print(len(df[df.year==1950]))

# %% How many movies were made from 1950 through 1959?
print(len(df[(df.year>=1950) & (df.year<=1959)]))
print(len(df[df.year//10 == 195]))


# %% What are the ten most common movie names of all time?
print(df.title.value_counts().head(10))

# %% Plot the number of films that have been released each decade
# over the history of cinema.
(df.year // 10 * 10).value_counts().sort_index().plot(kind='bar')


# %% Plot the number of "Hamlet" films made each decade.
h = df[df.title=="Hamlet"]
(h.year //10*10).value_counts().sort_index().plot(kind='bar')

