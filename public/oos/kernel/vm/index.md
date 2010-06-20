<h2>oos - userland in a virtual environment</h2>

<p>To minimize the amount of architecture-dependant code, use a kernel-level virtual environment for userland software. 
This virtual environment will allow software to run isolated from the kernel, and offer access to certain functions defined in the kernel that need to be used in userland (for instance, input/output and process management).</p>
<p>To do this, there are a few options:</p>
<ol>
	<li>Software fault isolation - sandboxing</li>
	<li>Full virtual machine that can run elf executables</li>
	<li>Kernel-level interpreter</li>
</ol>
<p>(No information on software fault isolation)</p>
<p></p>
<p>For the virtual machine, the elf file will, to an extent, be interpreted - all allowed operations will be done by the kernel using the allocated stack for the executable. 
One possible method to allow access kernel functions from userland would be to abuse the linking ability of elf executables, and have the kernel "link" the functions in. 
An alternative method would be to use system calls, this would not completely replace the normal userland/kernel separation, but just make the userland implementation work across all architectures (qemu-style virtualization).</p>
<p></p>
<p>The kernel-level interpreter would be a normal interpreter with whitelisted kernel functions (input/output, process management, etc.) made available as built-in functions.  This requires finding a suitable language.</p>
<p></p>
<p>General (incomplete) layout of the kernel:</p>
<ul>
	<li>Drivers
		<ul>
		<li>display</li>
		<li>audio</li>
		<li>networking</li>
		</ul>
	</li>
	<li>Scheduler
		<ul>
		<li>context switches</li>
		<li>tracking process/thread information</li>
		</ul>
	</li>
	<li><abbr title="Hardware Acess Layer">HAL</abbr>
		<ul>
		<li>memory management</li>
		<li>interrupts</li>
		<li>power management</li>
		<li>descriptor tables</li>
		<li>functions:
			<ul>
			<li>halt</li>
			<li>panic</li>
			<li>enableInterrupts</li>
			<li>disableInterrupts</li>
			</ul>
		</li>
		</ul>
	</li>
	<li>Virtual Environment
		<ul>
		<li>kernel library interface (userland access to whitelisted kernel functions)</li>
		<li>userland applications</li>
		</ul>
	</li>
</ul>
