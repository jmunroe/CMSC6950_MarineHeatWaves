from matplotlib import pyplot as plt
import pandas as pd

df = pd.read_csv('data.csv', index_col=0, parse_dates=[0])

df = df[df.Q_FLAG.isin( [1, 3, 5, 6])]
plt.figure(figsize=(12, 4))
plt.scatter(df.index, df.SSTP, s=3)
plt.xlabel('Date')
plt.ylabel('SST $^\circ$C')
plt.grid()
plt.savefig('filtered_sst_timeseries.png')
