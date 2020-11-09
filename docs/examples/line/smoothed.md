# Smoothed Line Chart

In this example, we are going to create a smoothed line chart to show the quarterly market share of Investors Exchange in U.S. equities market since it was launched in 2016. The final chart looks like below:

<span style="display:block;text-align:center">
![Final Chart](../../assets/img/line.smoothed.step.final.png)
</span>

## Overview of Data
The same dataset is used in this example. For a detailed description of the data, see [Overview of Data](../basic/#overview-of-data) in [Basic Line Chart](../basic/).

## Cubic Spline
There is no built-in function to perform cubic spline interpolation in Kx Deverloper libraries. A version is implemented in ``.qlib.math.spline`` according to the wiki page for [Spline interpolation](https://en.wikipedia.org/wiki/Spline_interpolation).

```q
// .line.smoothed.ff
t1:select quarter,mktshr,x:i,y:mktshr from .line.iexMktShare;
t2:.qlib.math.spline[t1;`quarter;`mktshr];

xfmt:{
  i:floor x;
  m:exec quarter from .line.iexMktShare;
  $[0=i mod 2;m i;`]
  };
yfmt:{`$.qlib.utils.toFixed[1;100*x],"%"};

.qp.go[600;400;] 
  .qp.title["Smoothed Line Chart"]
  .qp.stack (
    .qp.point[t1;`x;`y;] 
       .qp.s.geom[`size`colour`fill`strokewidth!(2;`red;`white;1)]
      ,.qp.s.labels[`x`y!(`Quarter;`$"Market Share (%)")]
      ,.qp.s.scale[`x;.gg.scale.format[xfmt;] .gg.scale.linear]
      ,.qp.s.scale[`y;.gg.scale.format[yfmt;] .gg.scale.linear];
    .qp.line[t2;`x;`y;] 
       .qp.s.geom[`fill`decorations!(`blue;0b)]
      ,.qp.s.labels[`x`y!(`Quarter;`$"Market Share (%)")]
    )
```

<span style="display:block;text-align:center">
![Final Step](../../assets/img/line.smoothed.step.final.png)
</span>
