import pandas as pd

# %% import release file

r = pd.DataFrame.from_csv("data/release_dates.csv", index_col=None)

# %% how many movies are made in india each year
i = r[r.country=="India"]
i.groupby(['year']).size().plot(kind='area')
