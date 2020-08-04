from matplotlib import pyplot as plt
import pandas as pd

df = pd.read_csv('data.csv', index_col=0, parse_dates=[0])
plt.figure(figsize=(12, 4))

# use plt.cm.get_cmap(cmap, N) to get an N-bin version of cmap
cmap = plt.cm.get_cmap('Accent', 7)
plt.scatter(df.index, df.SSTP, s=3, 
            c=df.Q_FLAG, cmap=cmap)

# This function formatter will replace integers with target names
qc_codes = {0 :'0 Blank', 
            1 : '1 Good', 
            3: '3 Doubtful', 
            4: '4 Erroneous', 
            5: '5 Changes', 
            6: '6 Acceptable', 
            7: '7 Off position'}
formatter = plt.FuncFormatter(lambda val, loc: qc_codes[val])

# We must be sure to specify the ticks matching our target names
plt.colorbar(ticks=[0, 1, 3, 4, 5, 6, 7], format=formatter);

## Set the clim so that labels are centered on each block
plt.clim(0.5, 7.5)
plt.xlabel('Date')
plt.ylabel('SST $^\circ$C')
plt.grid()
plt.savefig('qc_sst_timeseries.png')
