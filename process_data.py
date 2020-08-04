import numpy as np
import pandas as pd
from datetime import date
import marineHeatWaves as mhw
import pickle

df = pd.read_csv('data.csv', index_col=0, parse_dates=[0])

# resample as daily average
df_daily = df.resample('D').mean()

# create arrays a list consistent with mhw package
dates = [tt.date() for tt in df_daily.index.to_pydatetime()]
t = np.array([tt.toordinal() for tt in dates])
sst = np.array(df_daily.SSTP)

mhws, clim = mhw.detect(t, sst)
                        
with open('mhws_data.pkl', 'wb') as f:
    pickle.dump([dates, t, sst, mhws, clim], f)
