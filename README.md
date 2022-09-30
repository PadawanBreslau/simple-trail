.h1 Simple Trail

.h3 Purpose
Reading and interpretation on trail files (GPX,...)

.h3 Usage

```
      @parser = Parser::Gpx.new(@file)

      @parser.read
      @points = @parser.points
```

```
Manipulation::Enricher.new(@points, @enrichment_level, @offset).enrich
```

Licence: MIT
