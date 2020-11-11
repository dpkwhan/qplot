// @author David Han
//
// @kind function
//
// @fileOverview Create a stacked line chart.
//
// @example Create and render a stacked line chart specification:
// .qp.go[600;400;] .line.stacked.f03[]
//
// @returns {table} a GG specification (for example, ``.qp.point[t; `x; `y; ::]``)

{
  t:0!update sums shares by year from 
    `year`exchange xasc select from .line.mktVolume;
  t:update string year,shares:shares*1e-9 from t;
  
  .qp.line[t;`year;`shares;] 
     .qp.s.aes[`group`fill; `exchange`exchange]
    ,.qp.s.labels[`x`y!(`Year;`$"Market Volume (billion shares)")]
    ,.qp.s.geom[`size`colour`decorations!(2;`red;1b)]
  }
