# README

This is the repository for a *Ruby* project that verifies the correctness of complex *uninhabited aerial vehicle* (UAV) mission plans.

The project is presented in the postdoctoral thesis *Cascading Verification: An Integrated Method for Domain-Specific Model Checking*, which is available online at: [https://github.com/fokionzd/phd-thesis](https://github.com/fokionzd/phd-thesis)

Clone and navigate to the repository.

```
git clone git@github.com:fokionzd/uav-missions.git
cd uav-missions/
```

Use *Homebrew* to install dependencies on *macOS*.

```
brew install ruby
brew install swi-prolog
gem install activesupport --no-rdoc --no-ri
gem install kwalify --no-rdoc --no-ri
```

Validate a mission plan against the schema file ```schema.yaml```.

```
(cd mission-executive/operations/; kwalify -lf schema.yaml operation_1a.yaml)
```

Execute a mission plan.

```
chmod +x mission-executive/mission.rb
(cd mission-executive/; ./mission.rb operation_1a)
```

Use the optional parameter ```filter``` to output the execution stack of each method call to the standard output stream.

```
(cd mission-executive/; ./mission.rb filter operation_1a)
```

Execute all mission plans.

```
(cd mission-executive/; ./mission.rb)
```

Generate *PRISM DTMC* and *PCTL* code from templates.

```
(cd mission-executive/; chmod +x asset_template.rb survivability_template.rb property_template.rb)
(cd mission-executive/; ./asset_template.rb; ./survivability_template.rb; ./property_template.rb)
```

Use *SWI-Prolog* to classify UAV mission elements.

```
(cd prolog-kb/; swipl)
?- [operation_1a].
?- halt.
```

Execute the parser.

```
chmod +x parser/parser.rb
./parser/parser.rb
```
