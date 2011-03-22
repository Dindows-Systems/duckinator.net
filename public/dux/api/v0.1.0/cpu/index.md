# Dux API #

## CPU API ##

Provides information about all CPU(s) on the system.

* <p><span class="func-type">char*</span> <span class="func-name">CPUBrand</span>():</p>
  Returns a `String` representation of the CPU brand, as the system reports it. Possible values include, but are not limited to:
  * "<span class="monospace">AMDisbetter!</span>"
  * "<span class="monospace">AuthenticAMD</span>"
  * "<span class="monospace">GenuineIntel</span>"
  * "<span class="monospace">CentaurHauls</span>"
  * "<span class="monospace">TransmetaCPU</span>"
  * "<span class="monospace">GenuineTMx86</span>"
  * "<span class="monospace">CyrixInstead</span>"
  * "<span class="monospace">NexGenDriven</span>"
  * "<span class="monospace">UMC UMC UMC </span>"
  * "<span class="monospace">SiS SiS SiS </span>"
  * "<span class="monospace">Geode by NSC</span>"
  * "<span class="monospace">RiseRiseRise</span>"

* <p><span class="func-type">char*</span> <span class="func-name">CPUFamily</span>():</p>
  Returns a `String` representation of the CPU family, as the system reports it. Possible values include, but are not limited to:
  *

* <p><span class="func-type">char*</span> <span class="func-name">CPUModel</span>():</p>
  Returns a `String` representation of the CPU model, as the system reports it. Possible values include, but are not limited to:
  *

* <p><span class="func-type">int</span> <span class="func-name">CPUPopulation</span>():</p>
  Returns an `Integer` representation of the number of CPUs in the system.

* <p><span class="func-type">int</span> <span class="func-name">CPUActivePopulation</span>():</p>
  Returns an `Integer` representation of the number of enabled CPUs in the system.

* <p><span class="func-type">CPU_features_t</span>  <span class="func-name">CPUFeatures</span>():</p>
  Returns a `CPU_features_t` struct (or a fully-equivalent alternative representation) containing information about CPU features.
  *TODO:* Find out exactly which features are important on all systems (not x86-specific, we have CPUID functions for that).

* <p><span class="func-type">int</span> <span class="func-name">CPUCacheSize</span>():</p>
  Returns a `Integer` representation of the size of all caches combined.

* <p><span class="func-type">char*</span> <span class="func-name">CPUSerialNumber</span>():</p>
  Returns a `String` representation of the serial number of the processor.

### Possible additions ###

* <p><span class="func-type">char*</span> <span class="func-name">CPUShortBrand</span>():</p>
  Returns a common-name representation of the CPU brand. Possible values include, but are not limited to:
  * AMD
  * Intel
  * VIA
  * Transmeta
  * Cyrix
  * NexGen
  * UMC
  * NSC
  * Rise

