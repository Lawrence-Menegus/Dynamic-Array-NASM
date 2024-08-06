# Dynamic Array Program
<p>This assembly language program prompts the user to enter integers, which are then added to a dynamically allocated array. The program computes and displays the number of elements, sum, maximum, and minimum values of the array.</p>

### Program Overview
<p>The program performs the following tasks:</p>
<ul>
    <li>Prompts the user to enter integers until an end-of-file signal (ctrl-d) is received.</li>
    <li>Stores the entered integers in a dynamically allocated array.</li>
    <li>Resizes the array if the number of entered integers exceeds the initial size.</li>
    <li>Calculates the number of elements, sum, minimum, and maximum values in the array.</li>
    <li>Prints the results.</li>
</ul>

### Compile and Run the Program
<p>To compile and run the program, follow these steps in your terminal:</p>
<b>Assemble the Program</b>:
<pre><code>nasm -f elf64 DynamicArray.asm -o DynamicArray.o</code></pre>
<b>Link the Program</b>:

<pre><code>ld DynamicArray.o -o DynamicArray</code></pre>
<b>Run the Program</b>:

<pre><code>./DynamicArray</code></pre>

### Usage
<p>1. The program starts by prompting the user to enter integers:</p>
<ul>
    <li>Displays the message "Please enter integer data (ctrl-d to stop):".</li>
</ul>
<p>2. The user inputs integers, which are stored in a dynamically allocated array:</p>
<ul>
    <li>If the array bounds are exceeded, the array is resized.</li>
</ul>
<p>3. The program calculates the number of elements, sum, minimum, and maximum values:</p>
<ul>
    <li>The results are stored in corresponding variables.</li>
</ul>
<p>4. The program prints the results:</p>
<ul>
    <li>Displays the number of elements, sum, minimum, and maximum values.</li>
</ul>

### Contributor 
<p>Lawrence Menegus</p>
