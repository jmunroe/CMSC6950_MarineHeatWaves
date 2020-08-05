import numpy as np
import pandas as pd
from datetime import date
import marineHeatWaves as mhw
import pickle as pkl

# load raw data
df = pd.read_csv('data.csv', index_col=0, parse_dates=[0])

# preprocess according to quality control flags
qc_codes = {0 :'0 Blank', 2 : '', 1 : '1 Good', 3: '3 Doubtful', 
            4: '4 Erroneous', 5: '5 Changes', 
            6: '6 Acceptable', 7: '7 Off position'}
df = df[df.Q_FLAG.isin( [1,3, 5, 6])]

# resample as daily average
df_daily = df.resample('D').mean()

# create arrays a list consistent with mhw package
dates = [tt.date() for tt in df_daily.index.to_pydatetime()]
t = np.array([tt.toordinal() for tt in dates])
sst = np.array(df_daily.SSTP)

# detect marine heat waves
mhws, clim = mhw.detect(t, sst)
                  
# save results
with open('mhws_data.pkl', 'wb') as f:
    pkl.dump([dates, t, sst, mhws, clim], f)
