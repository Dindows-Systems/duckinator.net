# Dux API #

## CPU API ##

Provides information about all CPU(s) on the system.

* <p><span class="type">char*</span> <span class="name">CPUBrand</span>():</p>
  Returns a `String` representation of the CPU brand, as the system reports it. Possible values include, but are not limited to:
  * "<code>AMDisbetter!</code>"
  * "<code>AuthenticAMD</code>"
  * "<code>GenuineIntel</code>"
  * "<code>CentaurHauls</code>"
  * "<code>TransmetaCPU</code>"
  * "<code>GenuineTMx86</code>"
  * "<code>CyrixInstead</code>"
  * "<code>NexGenDriven</code>"
  * "<code>UMC UMC UMC </code>"
  * "<code>SiS SiS SiS </code>"
  * "<code>Geode by NSC</code>"
  * "<code>RiseRiseRise</code>"

* <p><span class="type">char*</span> <span class="name">CPUFamily</span>():</p>
  Returns a `String` representation of the CPU family, as the system reports it. Possible values include, but are not limited to:
  *

* <p><span class="type">char*</span> <span class="name">CPUModel</span>():</p>
  Returns a `String` representation of the CPU model, as the system reports it. Possible values include, but are not limited to:
  *

* <p><span class="type">int</span> <span class="name">CPUPopulation</span>():</p>
  Returns an `Integer` representation of the number of CPUs in the system.

* <p><span class="type">int</span> <span class="name">CPUActivePopulation</span>():</p>
  Returns an `Integer` representation of the number of enabled CPUs in the system.

* <p><span class="type">CPU_features_t</span>  <span class="name">CPUFeatures</span>():</p>
  Returns a `CPU_features_t` struct (or a fully-equivalent alternative representation) containing information about CPU features.
  *TODO:* Find out exactly which features are important on all systems (not x86-specific, we have CPUID functions for that).

* <p><span class="type">int</span> <span class="name">CPUCacheSize</span>():</p>
  Returns a `Integer` representation of the size of all caches combined.

* <p><span class="type">char*</span> <span class="name">CPUSerialNumber</span>():</p>
  Returns a `String` representation of the serial number of the processor.

### Possible additions ###

* <p><span class="type">char*</span> <span class="name">CPUShortBrand</span>():</p>
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

