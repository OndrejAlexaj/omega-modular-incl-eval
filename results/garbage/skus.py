import datetime
import pandas as pd
import re as re
import tabulate as tab
import math
from IPython.display import display

import evallib as el

df_hy = el.read_file('opt/hyperltl_output.csv')
df_t = el.read_file('opt/termination_output.csv')
df_r = el.read_file('opt/rabit_hoa_output.csv')
df_hy_noopt = el.read_file('no_opt/hyperltl_no_opt.csv')
df_term_noopt = el.read_file('no_opt/termination_no_opt.csv')
df_r_noopt = el.read_file('no_opt/rabit_no_opt.csv')
df_combined = pd.concat([df_hy, df_t, df_r], ignore_index=True)
df_combined_noopt = pd.concat([df_hy_noopt, df_term_noopt, df_r_noopt], ignore_index=True)

df_hy = df_hy[~df_hy.isin(['MISSING', 'ERR']).any(axis=1)]
df_t = df_t[~df_t.isin(['MISSING', 'ERR']).any(axis=1)]
df_r = df_r[~df_r.isin(['MISSING', 'ERR']).any(axis=1)]
df_hy_noopt = df_hy_noopt[~df_hy_noopt.isin(['MISSING', 'ERR']).any(axis=1)]
df_term_noopt = df_term_noopt[~df_term_noopt.isin(['MISSING', 'ERR']).any(axis=1)]
df_r_noopt = df_r_noopt[~df_r_noopt.isin(['MISSING', 'ERR']).any(axis=1)]
df_combined = df_combined[~df_combined.isin(['MISSING', 'ERR']).any(axis=1)]
# df_combined_noopt = df_combined_noopt[~df_combined_noopt.isin(['MISSING', 'ERR']).any(axis=1)]

df_hy_summary = el.summary_stats(df_hy)
df_t_summary = el.summary_stats(df_t)
df_r_summary = el.summary_stats(df_r)
df_hy_noopt_summary = el.summary_stats(df_hy_noopt)
df_term_noopt_summary = el.summary_stats(df_term_noopt)
df_r_noopt_summary = el.summary_stats(df_r_noopt)
df_combined_summary = el.summary_stats(df_combined)
df_combined_noopt_summary = el.summary_stats(df_combined_noopt)

TIMEOUT = 900000
TIMEOUT_VAL = TIMEOUT * 1.1
TIME_MIN = 0.01

to_compare_states_cnt = [
                        #  "kofola_high_cnt-states_cnt",
                        #  "kofola_medium_cnt-states_cnt",
                        #  "kofola_low_cnt-states_cnt",
                         "kofola_no_preproc_cnt-states_cnt",
                         "autfilt_cnt-states_cnt"
                        ]

def plot_states_cnt(df_eng, df_eng_summary):
  df_eng_copy = df_eng.copy()
  df_eng_summary_copy = df_eng_summary.copy()
  pair_list = [(meth1, meth2) for meth1 in to_compare_states_cnt for meth2 in to_compare_states_cnt if meth1 != meth2]
  # Remove duplicates
  new_list = list()
  for (meth1, meth2) in pair_list:
    if (meth2, meth1) not in new_list:
      new_list.append((meth1, meth2))

  pair_list = new_list

  plots = list()
  MAX=df_eng_summary_copy['max'].max() * 1.8
  df_eng_copy = el.sanitize_results(df_eng_copy,df_eng_summary_copy,TIMEOUT_VAL)
  for (meth1, meth2) in pair_list:
    plots.append(el.scatplot(df_eng_copy, {'x': meth1, 'y': meth2, 'max': MAX, 'states': True, 'save': True}))
  for plot in plots:
      display(plot)

# plot_states_cnt(df_hy_noopt, df_hy_noopt_summary)
# print(df_hy_noopt)
# print(df_hy_noopt_summary)
# plot_states_cnt(df_term_noopt, df_term_noopt_summary)
# plot_states_cnt(df_r_noopt, df_r_noopt_summary)
plot_states_cnt(df_combined_noopt, df_combined_noopt_summary)