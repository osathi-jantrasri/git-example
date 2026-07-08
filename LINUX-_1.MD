# แบบฝึกหัด Linux Command เบื้องต้น

**ระดับ:** ผู้เริ่มต้น  
**เวลาโดยประมาณ:** 3–4 ชั่วโมง  
**สิ่งที่ต้องเตรียม:** Linux Terminal (Ubuntu / Debian หรือใช้ WSL บน Windows)

---

## หมวดที่ 1 — การนำทางใน Filesystem

### ทฤษฎีสั้น ๆ
| คำสั่ง | ความหมาย |
|--------|----------|
| `pwd` | แสดง path ปัจจุบัน (Print Working Directory) |
| `ls` | แสดงรายการไฟล์/โฟลเดอร์ |
| `cd` | เปลี่ยน directory |

### แบบฝึกหัด 1.1
```
1. พิมพ์คำสั่งต่อไปนี้แล้วบันทึกผลลัพธ์
   $ pwd

IT-WRK2406-0073:/# pwd
/  

2. แสดงรายการไฟล์ใน home directory
   $ ls
   $ ls -l
   $ ls -la
   → ต่างกันอย่างไร?

ls แสดง ว่ามีอะไรใน directory บ้าง
ls -l แสดง อย่างละเอียด
ls -la แสดง อย่างละเอียด และไฟลล์ที่ซ่อนอยู่ด้วย

3. ไปยัง root directory แล้วกลับมา home
   $ cd /
   $ pwd
IT-WRK2406-0073:/# pwd
/
   $ cd ~
   $ pwd
IT-WRK2406-0073:~# pwd
/root

4. ไปยัง /etc แล้วใช้ cd .. กลับขึ้น 1 ระดับ
   $ cd /etc
   $ cd ..
   $ pwd
IT-WRK2406-0073:/# cd etc/
IT-WRK2406-0073:/etc# cd ..
IT-WRK2406-0073:/# pwd
/
```

### แบบฝึกหัด 1.2 — การนำทางด้วย `../` (Relative Path)

> `..` หมายถึง "โฟลเดอร์ที่อยู่เหนือขึ้นไป 1 ระดับ" สามารถซ้อนกันได้หลายชั้น

```
โครงสร้างสมมติ:
  /home/user/
  ├── workshop/
  │   ├── notes/
  │   └── docs/
  └── project/

1. เข้าไปใน notes/ แล้วย้ายไป docs/ โดยไม่ใช้ absolute path
   $ cd ~/workshop/notes
   $ cd ../docs
   $ pwd
   → ควรได้ /home/<user>/workshop/docs

IT-WRK2406-0073:/home/user/workshop# cd notes/
IT-WRK2406-0073:/home/user/workshop/notes# cd ../docs/
IT-WRK2406-0073:/home/user/workshop/docs# pwd
/home/user/workshop/docs

2. จาก docs/ ขึ้นไป 2 ระดับ (ถึง home)
   $ cd ../..
   $ pwd

IT-WRK2406-0073:/home/user/workshop/docs# cd ../..
IT-WRK2406-0073:/home/user# pwd
/home/user

3. ลองใช้ relative path กับคำสั่ง ls
   $ cd ~/workshop/notes
   $ ls ../docs
   → แสดงไฟล์ใน docs โดยไม่ต้อง cd เข้าไป

IT-WRK2406-0073:/home/user# cd workshop/notes/
IT-WRK2406-0073:/home/user/workshop/notes# ls ../docs/
IT-WRK2406-0073:/home/user/workshop/notes# ls -l ../docs/
total 0

4. คัดลอกไฟล์จากโฟลเดอร์พี่น้องด้วย ../
   $ cd ~/workshop/notes
   $ cp ../docs/note1.txt ./copied.txt
   $ ls

IT-WRK2406-0073:/home/user/workshop/docs# cd ../notes/
IT-WRK2406-0073:/home/user/workshop/notes# cp ../docs/note1.txt ./copied.txt
IT-WRK2406-0073:/home/user/workshop/notes# ls
copied.txt
```

### คำถามท้ายหมวด
- `ls -l` และ `ls -la` ต่างกันอย่างไร?
   
      `ls -l` จะโชว์ list ของ file และ directory อย่างละเอียด

      `ls -la` จะโชว์ list ของ file และ directory อย่างละเอียด และไฟลล์ที่ซ่อนอยู่ด้วย

- `.` และ `..` หมายถึงอะไร?

      `.` หมายถึง directory ปัจจุบัน

      `..` หมายถึง directory ที่อยู่เหนือขึ้นไป

- `cd ../../` กับ `cd ~` ให้ผลต่างกันอย่างไร?

      `cd ../../` คือการขึ้นไปโฟลเดอร์ที่อยู่ด้านบน 2 ครั้ง

      `cd ~` คือการไปที่ root directory

---

## หมวดที่ 2 — การจัดการไฟล์และโฟลเดอร์

### ทฤษฎีสั้น ๆ
| คำสั่ง | ความหมาย |
|--------|----------|
| `mkdir` | สร้างโฟลเดอร์ |
| `touch` | สร้างไฟล์เปล่า |
| `cp` | คัดลอกไฟล์/โฟลเดอร์ |
| `mv` | ย้ายหรือเปลี่ยนชื่อไฟล์ |
| `rm` | ลบไฟล์ |
| `rmdir` | ลบโฟลเดอร์ (ต้องว่างเปล่า) |

### แบบฝึกหัด 2.1 — สร้างโครงสร้างโฟลเดอร์
```
1. สร้างโฟลเดอร์ชื่อ "workshop" ใน home directory
   $ mkdir ~/workshop

2. เข้าไปใน workshop แล้วสร้างโฟลเดอร์ย่อย 3 โฟลเดอร์
   $ cd ~/workshop
   $ mkdir notes docs scripts

3. ตรวจสอบผลลัพธ์
   $ ls -l

IT-WRK2406-0073:/# cd ~
IT-WRK2406-0073:~# mkdir ~/workshop
IT-WRK2406-0073:~# cd ~/workshop/
IT-WRK2406-0073:~/workshop# mkdir notes docs scripts
IT-WRK2406-0073:~/workshop# ls -l
total 12
drwxr-xr-x    2 root     root          4096 Jul  8 07:46 docs
drwxr-xr-x    2 root     root          4096 Jul  8 07:46 notes
drwxr-xr-x    2 root     root          4096 Jul  8 07:46 scripts
```

### แบบฝึกหัด 2.2 — สร้างและจัดการไฟล์
```
1. สร้างไฟล์เปล่าใน notes/
   $ touch notes/note1.txt notes/note2.txt

2. คัดลอก note1.txt ไปยัง docs/
   $ cp notes/note1.txt docs/

3. เปลี่ยนชื่อ note2.txt เป็น ideas.txt
   $ mv notes/note2.txt notes/ideas.txt

4. ลบ docs/note1.txt
   $ rm docs/note1.txt

5. ตรวจสอบโครงสร้างทั้งหมด
   $ ls -R ~/workshop

IT-WRK2406-0073:~/workshop# touch notes/note1.txt notes/note2.txt
IT-WRK2406-0073:~/workshop# cp notes/note1.txt docs/
IT-WRK2406-0073:~/workshop# mv notes/note2.txt notes/idea.txt
IT-WRK2406-0073:~/workshop# rm docs/note1.txt
IT-WRK2406-0073:~/workshop# ls -R ~/workshop/
/root/workshop/:
docs     notes    scripts

/root/workshop/docs:

/root/workshop/notes:
idea.txt   note1.txt

/root/workshop/scripts:
```

### ⚠️ ข้อควรระวัง
- `rm` ลบถาวร ไม่มี Recycle Bin
- `rm -rf` อันตรายมาก — ลบโฟลเดอร์และทุกอย่างข้างใน

---

## หมวดที่ 3 — การอ่านและเขียนไฟล์

### ทฤษฎีสั้น ๆ
| คำสั่ง | ความหมาย |
|--------|----------|
| `cat` | แสดงเนื้อหาไฟล์ / ต่อไฟล์หลายไฟล์เข้าด้วยกัน |
| `nano` | text editor ใน terminal |
| `echo` | พิมพ์ข้อความ |
| `>` | เขียนทับไฟล์ |
| `>>` | ต่อท้ายไฟล์ |
| `head` | แสดง N บรรทัดแรก |
| `tail` | แสดง N บรรทัดท้าย |
| `wc` | นับบรรทัด/คำ/ตัวอักษร |

### แบบฝึกหัด 3.1 — cat เพิ่มเติม
```
1. เขียนข้อความลงไฟล์
   $ echo "สวัสดี Linux" > ~/workshop/notes/hello.txt
   $ cat ~/workshop/notes/hello.txt

IT-WRK2406-0073:~/workshop# echo "สวัสดี Linux" > ~/workshop/notes/hello.txt
IT-WRK2406-0073:~/workshop# cat ~/workshop/notes/hello.txt
สวัสดี Linux

2. ต่อท้ายข้อความ
   $ echo "บรรทัดที่ 2" >> ~/workshop/notes/hello.txt
   $ echo "บรรทัดที่ 3" >> ~/workshop/notes/hello.txt
   $ cat ~/workshop/notes/hello.txt

IT-WRK2406-0073:~/workshop# echo "บรรทัดที่ 2" >> ~/workshop/notes/hello.txt
IT-WRK2406-0073:~/workshop# echo "บรรทัดที่ 3" >> ~/workshop/notes/hello.txt
IT-WRK2406-0073:~/workshop# cat ~/workshop/notes/hello.txt
สวัสดี Linux
บรรทัดที่ 2
บรรทัดที่ 3

3. แสดงพร้อมเลขบรรทัด
   $ cat -n ~/workshop/notes/hello.txt

IT-WRK2406-0073:~/workshop# cat -n ~/workshop/notes/hello.txt
     1  สวัสดี Linux
     2  บรรทัดที่ 2
     3  บรรทัดที่ 3

4. สร้างอีก 1 ไฟล์ แล้วต่อ 2 ไฟล์เข้าด้วยกัน (concatenate)
   $ echo "ไฟล์ที่ 2 บรรทัด A" > ~/workshop/notes/extra.txt
   $ echo "ไฟล์ที่ 2 บรรทัด B" >> ~/workshop/notes/extra.txt
   $ cat ~/workshop/notes/hello.txt ~/workshop/notes/extra.txt

IT-WRK2406-0073:~/workshop# echo "ไฟลล์ที่ 2 บรรทัด A" > ~/workshop/notes/extra.tx
t
IT-WRK2406-0073:~/workshop# echo "ไฟลล์ที่ 2 บรรทัด B" >> ~/workshop/notes/extra.t
xt
IT-WRK2406-0073:~/workshop# cat ~/workshop/notes/hello.txt ~/workshop/notes/ex
tra.txt
สวัสดี Linux
บรรทัดที่ 2
บรรทัดที่ 3
ไฟลล์ที่ 2 บรรทัด A
ไฟลล์ที่ 2 บรรทัด B

5. รวม 2 ไฟล์บันทึกเป็นไฟล์ใหม่
   $ cat ~/workshop/notes/hello.txt ~/workshop/notes/extra.txt > ~/workshop/notes/combined.txt
   $ cat -n ~/workshop/notes/combined.txt

IT-WRK2406-0073:~/workshop# cat ~/workshop/notes/hello.txt ~/workshop/notes/ex
tra.txt > ~/workshop/notes/combined.txt

6. นับบรรทัด
   $ wc -l ~/workshop/notes/combined.txt

IT-WRK2406-0073:~/workshop# wc -l ~/workshop/notes/combined.txt
5 /root/workshop/notes/combined.txt

7. แสดงเฉพาะบรรทัดแรก / ท้าย
   $ head -2 ~/workshop/notes/combined.txt
   $ tail -2 ~/workshop/notes/combined.txt

IT-WRK2406-0073:~/workshop# head -2 ~/workshop/notes/combined.txt
สวัสดี Linux
บรรทัดที่ 2

IT-WRK2406-0073:~/workshop# tail -2 ~/workshop/notes/combined.txt
ไฟลล์ที่ 2 บรรทัด A
ไฟลล์ที่ 2 บรรทัด B
```

### แบบฝึกหัด 3.2 — nano (Text Editor)

> nano คือ editor แบบง่ายที่ใช้งานได้ทันทีใน terminal

```
ปุ่มสำคัญใน nano:
  Ctrl+O  → บันทึกไฟล์ (Write Out)
  Ctrl+X  → ออกจาก nano
  Ctrl+W  → ค้นหาข้อความ
  Ctrl+K  → ตัดทั้งบรรทัด
  Ctrl+U  → วางบรรทัด

1. เปิด nano สร้างไฟล์ใหม่
   $ nano ~/workshop/notes/myfile.txt

2. พิมพ์ข้อความต่อไปนี้ลงไป:
   วันนี้ฉันเรียน Linux
   คำสั่งที่ชอบคือ cat
   nano ใช้งานง่ายมาก

3. บันทึกด้วย Ctrl+O แล้วกด Enter เพื่อยืนยันชื่อไฟล์
4. ออกด้วย Ctrl+X

5. ตรวจสอบว่าบันทึกสำเร็จ
   $ cat ~/workshop/notes/myfile.txt

bandit.k@IT-WRK2406-0073 MINGW64 /d/test/git-example (osathi)
$ cat myfile.txt
วันนี้ฉันเรียน Linux
คำสั่งที่ชอบคือ cat
nano ใช้งานง่ายมาก

6. เปิดแก้ไขไฟล์เดิม เพิ่มบรรทัดใหม่ แล้วบันทึก
   $ nano ~/workshop/notes/myfile.txt

bandit.k@IT-WRK2406-0073 MINGW64 /d/test/git-example (osathi)
$ nano myfile.txt

bandit.k@IT-WRK2406-0073 MINGW64 /d/test/git-example (osathi)
$ cat myfile.txt
วันนี้ฉันเรียน Linux
คำสั่งที่ชอบคือ cat
nano ใช้งานง่ายมาก
Love pineapple
```

### แบบฝึกหัด 3.3 — ฝึก Redirect
```
1. บันทึกรายการไฟล์ใน /etc ลงไฟล์
   $ ls /etc > ~/workshop/docs/etc-list.txt

2. ตรวจสอบขนาดไฟล์ที่ได้
   $ wc -l ~/workshop/docs/etc-list.txt

3. เปิดดูเนื้อหาด้วย nano (read-only โดยไม่แก้ไข)
   $ nano ~/workshop/docs/etc-list.txt
   → ออกด้วย Ctrl+X

bandit.k@IT-WRK2406-0073 MINGW64 /d/test/git-example (osathi)
$ ls ./ > list.txt

bandit.k@IT-WRK2406-0073 MINGW64 /d/test/git-example (osathi)
$ wc -l list.txt
15 list.txt

bandit.k@IT-WRK2406-0073 MINGW64 /d/test/git-example (osathi)
$ nano list.txt

```

---

## หมวดที่ 3b — Symbolic Link ด้วย `ln`

### ทฤษฎีสั้น ๆ

`ln` ใช้สร้าง link ระหว่างไฟล์ มี 2 แบบ:

| ประเภท | คำสั่ง | ลักษณะ |
|--------|--------|--------|
| Hard link | `ln file link` | ชี้ไปยัง inode เดียวกัน — ลบต้นทางก็ยังเข้าถึงได้ |
| Symbolic link | `ln -s file link` | เหมือน shortcut — ถ้าต้นทางหายไป link จะพัง |

### แบบฝึกหัด 3b.1 — Symbolic Link
```
1. สร้าง symlink ชี้ไปที่ hello.txt
   $ ln -s ~/workshop/notes/hello.txt ~/workshop/docs/hello-link.txt

2. ตรวจสอบ link (สังเกต l ตัวแรกใน permission และลูกศร ->)
   $ ls -l ~/workshop/docs/

IT-WRK2406-0073:~# ln -s ~/workshop/notes/hello.txt ~/workshop/docs/hello-link.txt
IT-WRK2406-0073:~# ls -l ~/workshop/docs/
total 4
-rw-r--r--    1 root     root           388 Jul  8 08:11 etc-list.txt
lrwxrwxrwx    1 root     root            30 Jul  8 08:16 hello-link.txt -> /root/workshop/notes/hello.txt

3. อ่านผ่าน link ได้เหมือนไฟล์จริง
   $ cat ~/workshop/docs/hello-link.txt

IT-WRK2406-0073:~# cat ~/workshop/docs/hello-link.txt
สวัสดี Linux
บรรทัดที่ 2
บรรทัดที่ 3

4. แก้ไขไฟล์ต้นทาง แล้วดูผ่าน link
   $ echo "เพิ่มบรรทัดใหม่" >> ~/workshop/notes/hello.txt
   $ cat ~/workshop/docs/hello-link.txt
   → เนื้อหาอัปเดตทันทีผ่าน link

IT-WRK2406-0073:~# echo "เพิ่มบรรทัดใหม่" >> ~/workshop/notes/hello.txt
IT-WRK2406-0073:~# cat ~/workshop/docs/hello-link.txt
สวัสดี Linux
บรรทัดที่ 2
บรรทัดที่ 3
เพิ่มบรรทัดใหม่
```

### แบบฝึกหัด 3b.2 — Hard Link
```
1. สร้าง hard link
   $ ln ~/workshop/notes/extra.txt ~/workshop/docs/extra-hard.txt

2. เปรียบเทียบ inode number (ตัวเลขในคอลัมน์ที่ 1)
   $ ls -li ~/workshop/notes/extra.txt ~/workshop/docs/extra-hard.txt
   → inode เดียวกัน หมายความว่าเป็นไฟล์เดียวกัน

IT-WRK2406-0073:~# ln ~/workshop/notes/extra.txt ~/workshop/docs/extra-hard.txt
IT-WRK2406-0073:~# ls -li ~/workshop/notes/extra.txt ~/workshop/docs/extra-hard.txt
    796 -rw-r--r--    2 root     root            96 Jul  8 07:58 /root/workshop/docs/extra-hard.txt
    796 -rw-r--r--    2 root     root            96 Jul  8 07:58 /root/workshop/notes/extra.txt

3. แก้ไขผ่าน hard link แล้วตรวจสอบต้นทาง
   $ echo "แก้ผ่าน hard link" >> ~/workshop/docs/extra-hard.txt
   $ cat ~/workshop/notes/extra.txt

IT-WRK2406-0073:~# echo "แก้ผ่าน hard link" >> ~/workshop/docs/extra-hard.txt
IT-WRK2406-0073:~# cat ~/workshop/notes/extra.txt
ไฟลล์ที่ 2 บรรทัด A
ไฟลล์ที่ 2 บรรทัด B
แก้ผ่าน hard link

```

### คำถามท้ายหมวด
- symlink กับ hard link ต่างกันอย่างไรในทางปฏิบัติ?

      symlink เหมือน shortcut 

      hard link เหมือนเป็นไฟลล์เดียวกัน

- ถ้าลบไฟล์ต้นทางของ symlink จะเกิดอะไรขึ้น?

      ไฟลล์ link จะพังไม่สามารถใช้ได้

---

## หมวดที่ 3c — Archive และ Compression

### ทฤษฎีสั้น ๆ

Linux ใช้ **`tar`** เป็นคำสั่ง archive หลัก (ติดมากับทุก distro โดย default)  
`zip`/`unzip` มีใช้ได้แต่ต้องติดตั้งเพิ่ม — นิยมใช้เมื่อต้องแลกไฟล์กับ Windows

#### tar — option ที่ใช้บ่อย
| Option | ความหมาย |
|--------|----------|
| `c` | Create — สร้าง archive |
| `x` | Extract — แตกไฟล์ |
| `z` | ใช้ gzip compression (.tar.gz) |
| `j` | ใช้ bzip2 compression (.tar.bz2) |
| `v` | Verbose — แสดงรายการระหว่างทำ |
| `f` | ระบุชื่อไฟล์ (ต้องมีเสมอ ใส่ท้ายสุด) |

> จำง่าย: **`czf`** = pack, **`xzf`** = unpack

---

### แบบฝึกหัด 3c.1 — tar (Default Linux Archive)
```
1. เตรียมไฟล์สำหรับทดสอบ
   $ mkdir ~/workshop/archive-test
   $ echo "ไฟล์ A" > ~/workshop/archive-test/a.txt
   $ echo "ไฟล์ B" > ~/workshop/archive-test/b.txt
   $ echo "ไฟล์ C" > ~/workshop/archive-test/c.txt

IT-WRK2406-0073:~# mkdir ~/workshop/archive-test
IT-WRK2406-0073:~# echo "ไฟลล์ A" > ~/workshop/archive-test/a.txt
IT-WRK2406-0073:~# echo "ไฟล์ B" > ~/workshop/archive-test/b.txt
IT-WRK2406-0073:~# echo "ไฟล์ C" > ~/workshop/archive-test/c.txt

2. บีบอัดโฟลเดอร์เป็น .tar.gz
   $ cd ~/workshop
   $ tar -czf backup.tar.gz archive-test/
   $ ls -lh backup.tar.gz

IT-WRK2406-0073:~# cd ~/workshop/
IT-WRK2406-0073:~/workshop# tar -czf backup.tar.gz archive-test/
IT-WRK2406-0073:~/workshop# ls -lh backup.tar.gz
-rw-r--r--    1 root     root         216 Jul  8 08:34 backup.tar.gz

3. ดูรายการไฟล์ใน archive โดยไม่แตก
   $ tar -tzf backup.tar.gz

IT-WRK2406-0073:~/workshop# tar -tzf backup.tar.gz
archive-test/
archive-test/a.txt
archive-test/c.txt
archive-test/b.txt

4. แตกไฟล์ไปยังโฟลเดอร์ใหม่
   $ mkdir ~/workshop/extracted
   $ tar -xzf backup.tar.gz -C ~/workshop/extracted/
   $ ls ~/workshop/extracted/archive-test/

IT-WRK2406-0073:~/workshop# mkdir ~/workshop/extracted
IT-WRK2406-0073:~/workshop# tar -xzf backup.tar.gz -C ~/workshop/extracted/
IT-WRK2406-0073:~/workshop# ls ~/workshop/extracted/archive-test/
a.txt  b.txt  c.txt

5. แตกเฉพาะไฟล์เดียว
   $ tar -xzf backup.tar.gz -C ~/workshop/extracted/ archive-test/a.txt
```

### แบบฝึกหัด 3c.2 — zip / unzip
```
⚠️ ติดตั้งก่อนถ้ายังไม่มี:
   $ sudo apt install zip unzip -y

1. บีบอัดโฟลเดอร์เป็น .zip
   $ cd ~/workshop
   $ zip -r notes-backup.zip notes/
   $ ls -lh notes-backup.zip

2. ดูรายการไฟล์ใน zip โดยไม่แตก
   $ unzip -l notes-backup.zip

3. แตกไฟล์ไปยังโฟลเดอร์ใหม่
   $ unzip notes-backup.zip -d ~/workshop/zip-extracted/
   $ ls ~/workshop/zip-extracted/
```

### เปรียบเทียบ tar vs zip

| | `tar.gz` | `zip` |
|---|---|---|
| Default บน Linux | ✅ | ❌ (ต้องติดตั้ง) |
| นิยมบน Windows/macOS | ❌ | ✅ |
| บีบอัดหลายไฟล์พร้อมกัน | ✅ | ✅ |
| แตกเฉพาะบางไฟล์ได้ | ✅ | ✅ |

### คำถามท้ายหมวด
- `-czf` และ `-xzf` ต่างกันอย่างไร?

      `-czf` บีบอัดไฟลล์

      `-xzf` แตกไฟลล์

- ทำไม option `f` ต้องอยู่ท้ายสุด?

      ตามกฏตัวอักษร f ต้องอยู่ติดกับชื่อไฟลล์เสมอ

- เมื่อไหรควรใช้ zip แทน tar?

      เมื่อต้องการส่งไฟลล์ให้ระบบปฏิบัติการ window/mac

---

## หมวดที่ 4 — การค้นหาข้อมูล

### ทฤษฎีสั้น ๆ
| คำสั่ง | ความหมาย |
|--------|----------|
| `grep` | ค้นหาข้อความในไฟล์ |
| `find` | ค้นหาไฟล์/โฟลเดอร์ตาม attribute |
| `locate` | ค้นหาไฟล์จาก database (เร็วกว่า find) |
| `whereis` | หา path ของโปรแกรม + manual + source |

### แบบฝึกหัด 4.1 — grep
```
1. ค้นหาคำว่า "root" ในไฟล์ /etc/passwd
   $ grep "root" /etc/passwd

IT-WRK2406-0073:~/workshop# grep "root" /etc/passwd
root:x:0:0:root:/root:/bin/ash
operator:x:11:0:operator:/root:/sbin/nologin

2. ค้นหาแบบ case-insensitive
   $ grep -i "ROOT" /etc/passwd

IT-WRK2406-0073:~/workshop# grep -i "ROOT" /etc/passwd
root:x:0:0:root:/root:/bin/ash
operator:x:11:0:operator:/root:/sbin/nologin

3. แสดงเลขบรรทัดที่เจอ
   $ grep -n "root" /etc/passwd

IT-WRK2406-0073:~/workshop# grep -n "root" /etc/passwd
1:root:x:0:0:root:/root:/bin/ash
12:operator:x:11:0:operator:/root:/sbin/nologin

4. นับจำนวนบรรทัดที่เจอ
   $ grep -c "root" /etc/passwd

IT-WRK2406-0073:~/workshop# grep -c "root" /etc/passwd
2

5. ค้นหาแบบ recursive ในโฟลเดอร์
   $ grep -r "hello" ~/workshop/

IT-WRK2406-0073:~/workshop# grep -r "he" ~/workshop/
/root/workshop/docs/etc-list.txt:shells

6. ค้นหาไฟล์ .txt ใน workshop
   $ find ~/workshop -name "*.txt"

IT-WRK2406-0073:~/workshop# find ~/workshop/ -name "*.txt"
/root/workshop/docs/etc-list.txt
/root/workshop/docs/extra-hard.txt
/root/workshop/docs/hello-link.txt
/root/workshop/archive-test/a.txt
/root/workshop/archive-test/c.txt
/root/workshop/archive-test/b.txt
/root/workshop/extracted/archive-test/a.txt
/root/workshop/extracted/archive-test/c.txt
/root/workshop/extracted/archive-test/b.txt
/root/workshop/notes/idea.txt
/root/workshop/notes/combined.txt
/root/workshop/notes/extra.txt
/root/workshop/notes/note1.txt
/root/workshop/notes/hello.txt

7. ค้นหาเฉพาะโฟลเดอร์ใน workshop
   $ find ~/workshop -type d

IT-WRK2406-0073:~/workshop# find ~/workshop -type d
/root/workshop
/root/workshop/docs
/root/workshop/archive-test
/root/workshop/extracted
/root/workshop/extracted/archive-test
/root/workshop/scripts
/root/workshop/notes

```

### แบบฝึกหัด 4.2 — locate และ whereis
```
1. locate — ค้นหาไฟล์จาก database (เร็วมาก)
   ⚠️ ต้องติดตั้งและ update database ก่อน:
   $ sudo apt install mlocate -y
   $ sudo updatedb

   ค้นหาไฟล์ชื่อ passwd:
   $ locate passwd

   ค้นหาแบบ case-insensitive:
   $ locate -i Passwd

   จำกัดผลลัพธ์:
   $ locate passwd | head -10

   หมายเหตุ: locate ใช้ database ที่ update ทุกวัน
   ถ้าสร้างไฟล์ใหม่และยังไม่เจอ ให้รัน sudo updatedb ก่อน

2. whereis — หา path ของโปรแกรม
   $ whereis ls
   $ whereis python3
   $ whereis nano
   → แสดง binary path, man page path, source path

   เปรียบเทียบกับ which (หาเฉพาะ binary):
   $ which ls
   $ which python3

IT-WRK2406-0073:~/workshop# whereis ls
ls: /bin/ls

IT-WRK2406-0073:~/workshop# which ls
/bin/ls

IT-WRK2406-0073:~/workshop# whereis passwd
passwd: /usr/bin/passwd /etc/passwd
```

---

## หมวดที่ 4b — ดาวน์โหลดจากอินเทอร์เน็ต (wget และ curl)

### ทฤษฎีสั้น ๆ

| คำสั่ง | ความหมาย |
|--------|----------|
| `wget` | ดาวน์โหลดไฟล์จาก URL (เน้น download) |
| `curl` | รับ/ส่งข้อมูลผ่าน URL (ยืดหยุ่นกว่า — ใช้กับ API ได้) |

### แบบฝึกหัด 4b.1 — wget
```
⚠️ ติดตั้งถ้ายังไม่มี:
   $ sudo apt install wget -y

1. ดาวน์โหลดไฟล์
   $ wget https://example.com/robots.txt -P ~/workshop/docs/
   → -P กำหนดโฟลเดอร์ปลายทาง

IT-WRK2406-0073:~/workshop# wget https://example.com/robots.txt -P ~/workshop/docs/
Connecting to example.com (172.66.147.243:443)
wget: server returned error: HTTP/1.1 404 Not Found

2. ดาวน์โหลดและตั้งชื่อไฟล์เอง
   $ wget https://example.com/robots.txt -O ~/workshop/docs/my-robots.txt

3. ดาวน์โหลดแบบ quiet (ไม่แสดง progress)
   $ wget -q https://example.com/robots.txt -O ~/workshop/docs/quiet.txt

4. ดาวน์โหลดต่อจากที่ค้างไว้ (resume)
   $ wget -c https://example.com/largefile.zip -P ~/workshop/docs/
```

### แบบฝึกหัด 4b.2 — curl
```
⚠️ ติดตั้งถ้ายังไม่มี:
   $ sudo apt install curl -y

1. ดึงเนื้อหา URL แสดงบน terminal
   $ curl https://example.com

2. บันทึกลงไฟล์ด้วย -o
   $ curl -o ~/workshop/docs/example.html https://example.com

3. บันทึกโดยใช้ชื่อไฟล์จาก URL ด้วย -O
   $ curl -O https://example.com/robots.txt

4. ดู HTTP response header เท่านั้น
   $ curl -I https://example.com

5. เรียก REST API (ตัวอย่าง public API)
   $ curl https://httpbin.org/get
   $ curl https://httpbin.org/ip

6. ส่งข้อมูล POST
   $ curl -X POST https://httpbin.org/post \
     -H "Content-Type: application/json" \
     -d '{"name": "linux-learner"}'
```

### เปรียบเทียบ wget vs curl

| | `wget` | `curl` |
|---|---|---|
| จุดเด่น | ดาวน์โหลดไฟล์ใหญ่ resume ได้ | ยืดหยุ่น รองรับ HTTP method ครบ |
| ใช้กับ API | ไม่สะดวก | ✅ เหมาะมาก |
| recursive download | ✅ (`wget -r`) | ❌ |
| แสดง header | ไม่ตรงไป | ✅ (`curl -I`) |

---

## หมวดที่ 5 — ข้อมูล System และ Permissions

### ทฤษฎีสั้น ๆ
| คำสั่ง | ความหมาย |
|--------|----------|
| `whoami` | แสดงชื่อ user ปัจจุบัน |
| `df -h` | แสดงพื้นที่ disk |
| `free -h` | แสดง RAM ที่ใช้/ว่าง |
| `chmod` | เปลี่ยน permission ไฟล์ |
| `man` | เปิดคู่มือคำสั่ง |

### แบบฝึกหัด 5.0 — ทำความเข้าใจ File Permission

#### อ่านผล ls -l

```
$ ls -l ~/workshop/scripts/hello.sh
-rwxr-xr-- 1 alice developers 42 Jul 8 10:00 hello.sh
 ─┬──┬──┬─   ──┬──  ────┬────
  │  │  │      │        └─ group
  │  │  │      └────────── owner
  │  │  └───────────────── other  (r--)
  │  └──────────────────── group  (r-x)
  └─────────────────────── owner  (rwx)
```

#### ความหมายของแต่ละสิทธิ์

| สัญลักษณ์ | ค่า | ความหมายกับไฟล์ | ความหมายกับโฟลเดอร์ |
|----------|-----|----------------|-------------------|
| `r` | 4 | อ่านได้ | แสดงรายการใน ls ได้ |
| `w` | 2 | แก้ไขได้ | สร้าง/ลบไฟล์ในนั้นได้ |
| `x` | 1 | รันได้ (execute) | เข้าไปได้ (cd) |
| `-` | 0 | ไม่มีสิทธิ์ | ไม่มีสิทธิ์ |

#### ตัวอักษรแรกคือประเภทไฟล์

| ตัวอักษร | ประเภท |
|---------|--------|
| `-` | ไฟล์ธรรมดา |
| `d` | directory |
| `l` | symbolic link |
| `b` | block device |
| `c` | character device |

---

### แบบฝึกหัด 5.0a — อ่าน Permission
```
1. สร้างไฟล์และโฟลเดอร์ทดสอบ
   $ touch ~/workshop/perm-test.txt
   $ mkdir ~/workshop/perm-dir
   $ ls -l ~/workshop/

IT-WRK2406-0073:~/workshop# touch perm-test.txt
IT-WRK2406-0073:~/workshop# mkdir perm-dir
IT-WRK2406-0073:~/workshop# ls -l
total 28
drwxr-xr-x    2 root     root          4096 Jul  8 08:32 archive-test
-rw-r--r--    1 root     root           216 Jul  8 08:34 backup.tar.gz
drwxr-xr-x    2 root     root          4096 Jul  8 08:21 docs
drwxr-xr-x    3 root     root          4096 Jul  8 08:36 extracted
drwxr-xr-x    2 root     root          4096 Jul  8 08:00 notes
drwxr-xr-x    2 root     root          4096 Jul  8 09:20 perm-dir
-rw-r--r--    1 root     root             0 Jul  8 09:20 perm-test.txt
drwxr-xr-x    2 root     root          4096 Jul  8 07:46 scripts

2. อ่าน permission แต่ละบรรทัด — ตอบคำถาม:
   → ใครอ่านได้บ้าง?
   → ใครแก้ไขได้บ้าง?
   → ใคร execute ได้บ้าง?

perm-test.txt
owner rw
group r
other r

perm-dir
owner rwx
group rx
other rw
```

### แบบฝึกหัด 5.0b — chmod แบบ Symbolic
```
รูปแบบ: chmod [who][+/-/=][permission] file
  who: u (owner), g (group), o (other), a (all)
  +   เพิ่มสิทธิ์
  -   ลบสิทธิ์
  =   กำหนดสิทธิ์ใหม่ทั้งหมด

1. เพิ่มสิทธิ์ execute ให้ owner
   $ chmod u+x ~/workshop/perm-test.txt
   $ ls -l ~/workshop/perm-test.txt

2. เอาสิทธิ์ write ออกจาก group และ other
   $ chmod go-w ~/workshop/perm-test.txt
   $ ls -l ~/workshop/perm-test.txt

3. กำหนดสิทธิ์ใหม่ทั้งหมดให้ other เป็น read-only
   $ chmod o=r ~/workshop/perm-test.txt
   $ ls -l ~/workshop/perm-test.txt

4. ให้ทุกคน (all) อ่านและเขียนได้
   $ chmod a+rw ~/workshop/perm-test.txt
   $ ls -l ~/workshop/perm-test.txt
```

### แบบฝึกหัด 5.0c — chmod แบบ Octal (ตัวเลข)
```
วิธีคิด: บวกค่า r=4, w=2, x=1 สำหรับแต่ละกลุ่ม
  ตัวอย่าง:
    rwx = 4+2+1 = 7
    rw- = 4+2+0 = 6
    r-x = 4+0+1 = 5
    r-- = 4+0+0 = 4
    --- = 0+0+0 = 0

  chmod 755 → rwxr-xr-x  (owner ทำได้ทุกอย่าง, คนอื่นอ่าน+เข้าได้)
  chmod 644 → rw-r--r--  (owner อ่าน+เขียน, คนอื่นอ่านอย่างเดียว)
  chmod 600 → rw-------  (owner อ่าน+เขียน, คนอื่นทำไม่ได้เลย)
  chmod 777 → rwxrwxrwx  (ทุกคนทำได้ทุกอย่าง — ไม่ปลอดภัย)

1. กำหนด permission มาตรฐานสำหรับ script
   $ chmod 755 ~/workshop/scripts/hello.sh
   $ ls -l ~/workshop/scripts/hello.sh

IT-WRK2406-0073:~/workshop# touch ~/workshop/scripts/hello.sh
IT-WRK2406-0073:~/workshop# ls -l scripts/hello.sh
-rw-r--r--    1 root     root             0 Jul  8 09:28 scripts/hello.sh
IT-WRK2406-0073:~/workshop# chmod 755 scripts/hello.sh
IT-WRK2406-0073:~/workshop# ls -l scripts/hello.sh
-rwxr-xr-x    1 root     root             0 Jul  8 09:28 scripts/hello.sh

2. กำหนด permission มาตรฐานสำหรับไฟล์ข้อมูล
   $ chmod 644 ~/workshop/perm-test.txt
   $ ls -l ~/workshop/perm-test.txt

IT-WRK2406-0073:~/workshop# chmod 644 perm-test.txt
IT-WRK2406-0073:~/workshop# ls -l
total 28
drwxr-xr-x    2 root     root          4096 Jul  8 08:32 archive-test
-rw-r--r--    1 root     root           216 Jul  8 08:34 backup.tar.gz
drwxr-xr-x    2 root     root          4096 Jul  8 08:21 docs
drwxr-xr-x    3 root     root          4096 Jul  8 08:36 extracted
drwxr-xr-x    2 root     root          4096 Jul  8 08:00 notes
drwxr-xr-x    2 root     root          4096 Jul  8 09:20 perm-dir
-rw-r--r--    1 root     root             0 Jul  8 09:20 perm-test.txt
drwxr-xr-x    2 root     root          4096 Jul  8 09:28 scripts

3. ไฟล์ private — เฉพาะเจ้าของอ่านได้
   $ chmod 600 ~/workshop/notes/myfile.txt
   $ ls -l ~/workshop/notes/myfile.txt

IT-WRK2406-0073:~/workshop# chmod 600 ~/workshop/notes/myfile.txt
IT-WRK2406-0073:~/workshop# ls -l ~/workshop/notes/myfile.txt
-rw-------    1 root     root             0 Jul  8 09:32 /root/workshop/notes/myfile.txt

4. ทดสอบว่า permission ทำงานจริง
   $ chmod 000 ~/workshop/perm-test.txt    ← ไม่มีใครทำอะไรได้
   $ cat ~/workshop/perm-test.txt          ← ควร permission denied
   $ chmod 644 ~/workshop/perm-test.txt   ← คืนค่าปกติ
```

### แบบฝึกหัด 5.0d — chmod Recursive และ umask
```
1. เปลี่ยน permission ทั้งโฟลเดอร์ด้วย -R
   $ chmod -R 755 ~/workshop/scripts/
   $ ls -l ~/workshop/scripts/

2. ดูค่า umask — สิทธิ์ default เมื่อสร้างไฟล์ใหม่
   $ umask
   → ปกติได้ 0022

   วิธีอ่าน umask:
   - ไฟล์ใหม่:      666 - 022 = 644 (rw-r--r--)
   - โฟลเดอร์ใหม่:  777 - 022 = 755 (rwxr-xr-x)

3. สร้างไฟล์ใหม่แล้วดู permission default
   $ touch ~/workshop/umask-test.txt
   $ ls -l ~/workshop/umask-test.txt
   → ควรเป็น 644
```

### แบบฝึกหัด 5.0e — Special Permissions
```
1. Setuid (s) — รันด้วยสิทธิ์ของ owner ไม่ใช่ผู้รัน
   ดูตัวอย่างจริงในระบบ:
   $ ls -l /usr/bin/passwd
   → จะเห็น -rwsr-xr-x (s แทนที่ x ของ owner)

IT-WRK2406-0073:~/workshop# ls -l /usr/bin/passwd
lrwxrwxrwx    1 root     root            12 Dec  7  2023 /usr/bin/passwd -> /bin/busybox

2. Sticky bit (t) — เฉพาะเจ้าของไฟล์ลบไฟล์ตัวเองได้
   ดูตัวอย่างจริง:
   $ ls -ld /tmp
   → จะเห็น drwxrwxrwt (t ท้ายสุด)

IT-WRK2406-0073:~/workshop# ls -ld /tmp
drwxrwxrwt    5 root     root          4096 Jul  8 06:59 /tmp

3. ตั้ง sticky bit บนโฟลเดอร์แชร์
   $ mkdir ~/workshop/shared
   $ chmod 1777 ~/workshop/shared
   $ ls -ld ~/workshop/shared
   → ควรเห็น drwxrwxrwt

IT-WRK2406-0073:~/workshop# mkdir shared
IT-WRK2406-0073:~/workshop# chmod 1777 shared/
IT-WRK2406-0073:~/workshop# ls -ld shared/
drwxrwxrwt    2 root     root          4096 Jul  8 09:40 shared/
```

### ตารางสรุป Permission ที่ใช้บ่อย

| Permission | Octal | ใช้กับ |
|-----------|-------|--------|
| `rw-r--r--` | 644 | ไฟล์ทั่วไป |
| `rwxr-xr-x` | 755 | script / โฟลเดอร์ |
| `rw-------` | 600 | ไฟล์ private (SSH key, config) |
| `rwx------` | 700 | โฟลเดอร์ private |
| `rwxrwxr-x` | 775 | โฟลเดอร์ทีม |
| `rwxrwxrwt` | 1777 | /tmp หรือโฟลเดอร์แชร์ |

### คำถามท้ายหมวด
- `chmod 755` กับ `chmod u=rwx,go=rx` ให้ผลเหมือนกันหรือไม่?

      ให้ผลเหมือนกัน

- ทำไม `/tmp` ถึงต้องมี sticky bit?

      เพราะให้เจ้าของไฟลล์ลบไฟลล์ตัวเองได้ เป็นโฟลเดอร์ที่เก็บไฟลล์ชั่วคราวต้องลบบ่อย

- execute บนไฟล์ กับ execute บนโฟลเดอร์ต่างกันอย่างไร?

      บนไฟลล์ หมายความว่ารันไฟลล์ได้
      บนโฟลเดอร์ หมายความว่าสามารถเข้าไปดูข้างในได้

---

### แบบฝึกหัด 5.1
```
1. ดูว่า login เป็น user อะไร
   $ whoami

IT-WRK2406-0073:~/workshop# whoami
root

2. ตรวจสอบพื้นที่ disk
   $ df -h

IT-WRK2406-0073:~/workshop# df -h
Filesystem                Size      Used Available Use% Mounted on
none                      3.8G         0      3.8G   0% /lib/modules/5.15.167.4-microsoft-standard-WSL2
none                      3.8G      4.0K      3.8G   0% /mnt/host/wsl
drivers                 349.9G    187.9G    162.0G  54% /usr/lib/wsl/drivers
/dev/sdc               1006.9G     53.3M    955.6G   0% /
none                      3.8G     84.0K      3.8G   0% /mnt/host/wslg
/dev/sdc               1006.9G     53.3M    955.6G   0% /mnt/host/wslg/distro
none                      3.8G         0      3.8G   0% /usr/lib/wsl/lib
none                      3.8G         0      3.8G   0% /dev
none                      3.8G         0      3.8G   0% /run
none                      3.8G         0      3.8G   0% /run/lock
none                      3.8G         0      3.8G   0% /run/shm
none                      3.8G         0      3.8G   0% /dev/shm
none                      3.8G         0      3.8G   0% /run/user
tmpfs                     3.8G         0      3.8G   0% /sys/fs/cgroup
none                      3.8G     76.0K      3.8G   0% /mnt/host/wslg/versions.txt
none                      3.8G     76.0K      3.8G   0% /mnt/host/wslg/doc
none                      3.8G     84.0K      3.8G   0% /tmp/.X11-unix
C:\134                  349.9G    187.9G    162.0G  54% /mnt/host/c
D:\134                  602.7G     27.4G    575.3G   5% /mnt/host/d

3. ตรวจสอบ RAM
   $ free -h

IT-WRK2406-0073:~/workshop# free -h
              total        used        free      shared  buff/cache   available
Mem:           7.6G      305.8M        7.2G        2.6M      110.0M        7.1G
Swap:          2.0G           0        2.0G

4. สร้าง script ไฟล์และเปลี่ยน permission
   $ echo "echo Hello World" > ~/workshop/scripts/hello.sh
   $ ls -l ~/workshop/scripts/hello.sh
   $ chmod +x ~/workshop/scripts/hello.sh
   $ ls -l ~/workshop/scripts/hello.sh
   → permission เปลี่ยนอย่างไร?

IT-WRK2406-0073:~/workshop# echo "echo Hello World" > scripts/hello.sh
IT-WRK2406-0073:~/workshop# ls -l ~/workshop/scripts/hello.sh
-rwxr-xr-x    1 root     root            17 Jul  8 09:47 /root/workshop/scripts/hello.sh
IT-WRK2406-0073:~/workshop# chmod +x ~/workshop/scripts/hello.sh
IT-WRK2406-0073:~/workshop# ls -l ~/workshop/scripts/hello.sh
-rwxr-xr-x    1 root     root            17 Jul  8 09:47 /root/workshop/scripts/hello.sh

5. รัน script
   $ bash ~/workshop/scripts/hello.sh

IT-WRK2406-0073:~/workshop# chmod +x ~/workshop/scripts/hello.sh
IT-WRK2406-0073:~/workshop# scripts/hello.sh
Hello World

IT-WRK2406-0073:~/workshop# chmod -x ~/workshop/scripts/hello.sh
IT-WRK2406-0073:~/workshop# scripts/hello.sh
-ash: scripts/hello.sh: Permission denied

```

### แบบฝึกหัด 5.1b — su และ sudo (การใช้สิทธิ์สูงขึ้น)

> Linux แยก user ธรรมดากับ root ออกจากกันชัดเจน  
> `sudo` และ `su` คือทางเข้าถึงสิทธิ์ root

#### ความแตกต่าง

| | `sudo` | `su` |
|---|---|---|
| ความหมาย | รันคำสั่งเดียวในฐานะ root | สลับ session เป็น user อื่น |
| ต้องใส่รหัสผ่าน | รหัสผ่าน **ตัวเอง** | รหัสผ่าน **user ปลายทาง** |
| ความปลอดภัย | ดีกว่า — จำกัดขอบเขต | เสี่ยงกว่า — ได้ shell เต็ม |
| นิยมใช้บน | Ubuntu / Debian | CentOS / RHEL หรือ admin ขั้นสูง |

```
1. ทดสอบ sudo — รันคำสั่งในฐานะ root
   $ whoami
   $ sudo whoami
   → ผลต้องได้ "root"

2. ดูไฟล์ที่ปกติ user ธรรมดาเข้าไม่ได้
   $ cat /etc/shadow          ← ควร permission denied
   $ sudo cat /etc/shadow     ← ผ่านด้วย sudo

3. sudo -i — เปิด root shell ชั่วคราว (ระวัง)
   $ sudo -i
   # whoami                   ← prompt เปลี่ยนเป็น #
   # pwd                      ← จะอยู่ที่ /root
   # exit                     ← กลับออกมา

4. su — สลับไปเป็น user อื่น
   $ su - username            ← สลับพร้อม environment ของ user นั้น
   $ su username              ← สลับแต่ยัง environment เดิม
   $ exit                     ← กลับ user เดิม

5. su - (ไม่ระบุชื่อ) — สลับเป็น root โดยตรง
   $ su -
   Password: (ใส่รหัสผ่าน root)
   # whoami
   # exit

6. sudo su - — วิธีที่นิยมบน Ubuntu (ไม่ต้องรู้รหัส root)
   $ sudo su -
   # whoami
   # exit

7. ดูรายชื่อ user ที่ได้รับสิทธิ์ sudo
   $ sudo cat /etc/sudoers | grep -v "^#" | grep -v "^$"
```

### ⚠️ ข้อควรระวัง
- อย่า `sudo rm -rf /` — ลบทุกอย่างในระบบ
- ใช้ `sudo` เฉพาะเมื่อจำเป็น อย่า login เป็น root ตลอดเวลา
- `sudo -i` หรือ `su -` ให้ shell เต็ม — ทำผิดได้ง่าย ระวังให้มาก

### คำถามท้าย
- `sudo command` กับ `sudo -i` แล้วรัน command ต่างกันอย่างไร?
- ทำไม Ubuntu ถึงไม่เปิดให้ login เป็น root โดยตรงโดย default?

### แบบฝึกหัด 5.2 — chown (เปลี่ยนเจ้าของไฟล์)

> `chmod` เปลี่ยน **สิทธิ์** — `chown` เปลี่ยน **เจ้าของ**

```
รูปแบบคำสั่ง:
  chown <user>:<group> <file>
  chown <user> <file>       ← เปลี่ยนเฉพาะ owner
  chown :<group> <file>     ← เปลี่ยนเฉพาะ group

1. สร้างไฟล์ทดสอบและดู owner ปัจจุบัน
   $ touch ~/workshop/docs/owned.txt
   $ ls -l ~/workshop/docs/owned.txt
   → คอลัมน์ที่ 3 = owner, คอลัมน์ที่ 4 = group

2. ดู user และ group ที่มีในระบบ
   $ cat /etc/passwd | cut -d: -f1
   $ cat /etc/group | cut -d: -f1

3. เปลี่ยน owner เป็น root (ต้องใช้ sudo)
   $ sudo chown root ~/workshop/docs/owned.txt
   $ ls -l ~/workshop/docs/owned.txt

4. เปลี่ยน owner และ group พร้อมกัน
   $ sudo chown root:root ~/workshop/docs/owned.txt
   $ ls -l ~/workshop/docs/owned.txt

5. เปลี่ยน owner กลับเป็นตัวเอง
   $ sudo chown $USER:$USER ~/workshop/docs/owned.txt
   $ ls -l ~/workshop/docs/owned.txt

6. เปลี่ยน owner แบบ recursive (-R) ทั้งโฟลเดอร์
   $ sudo chown -R $USER:$USER ~/workshop/docs/
   $ ls -l ~/workshop/docs/
```

### คำถาม
- `chmod` กับ `chown` ต่างกันอย่างไร?
- ทำไมต้องใช้ `sudo` กับ `chown`?

### แบบฝึกหัด 5.2b — history (ประวัติคำสั่ง)

> `history` แสดงคำสั่งที่เคยพิมพ์ไว้ทั้งหมด ช่วยให้ไม่ต้องพิมพ์คำสั่งยาว ๆ ซ้ำ

```
1. ดูประวัติคำสั่งทั้งหมด
   $ history

2. ดูแค่ 10 คำสั่งล่าสุด
   $ history 10

3. ค้นหาคำสั่งที่เคยใช้ด้วย grep
   $ history | grep "tar"
   $ history | grep "mkdir"

4. รันคำสั่งซ้ำด้วยเลขลำดับ (! + เลข)
   $ history 5
   → สมมติบรรทัดที่ 42 คือ ls -la ~/workshop
   $ !42
   → รัน ls -la ~/workshop ทันที

5. รันคำสั่งล่าสุดซ้ำ
   $ !!

6. ค้นหาแบบ interactive ด้วย Ctrl+R
   กด Ctrl+R แล้วพิมพ์ "tar"
   → แสดงคำสั่ง tar ล่าสุดที่เคยพิมพ์
   → กด Enter เพื่อรัน หรือ Ctrl+C เพื่อยกเลิก

7. ล้าง history (ระวัง — ย้อนกลับไม่ได้)
   $ history -c
```

### ⚡ Shortcut ที่ควรรู้
| Shortcut | ความหมาย |
|----------|----------|
| ↑ / ↓ | เลื่อนดูคำสั่งก่อนหน้า/ถัดไป |
| Ctrl+R | ค้นหาคำสั่งใน history แบบ reverse |
| `!!` | รันคำสั่งล่าสุดซ้ำ |
| `!<n>` | รันคำสั่งลำดับที่ n |
| `!<text>` | รันคำสั่งล่าสุดที่ขึ้นต้นด้วย text |

### แบบฝึกหัด 5.3 — อ่าน Manual
```
1. เปิดคู่มือคำสั่ง ls
   $ man ls
   → กด q เพื่อออก

2. ใช้ --help แทน man
   $ ls --help
```

---

## หมวดที่ 5b — Package Manager (apt และ yum)

### ทฤษฎีสั้น ๆ

Package manager คือเครื่องมือติดตั้ง/ถอนโปรแกรมบน Linux โดยอัตโนมัติ  
ใช้คนละตัวขึ้นอยู่กับ distro:

| Distro | Package Manager | คำสั่ง |
|--------|----------------|--------|
| Ubuntu, Debian | APT | `apt` |
| CentOS, RHEL, Fedora (เก่า) | YUM | `yum` |
| Fedora, RHEL 8+ | DNF | `dnf` (ทดแทน yum) |

> `yum` และ `dnf` ใช้ syntax เดียวกันเกือบทั้งหมด — เปลี่ยนแค่ชื่อคำสั่ง

---

### แบบฝึกหัด 5b.1 — apt (Ubuntu / Debian)
```
1. อัปเดตรายการ package ล่าสุดจาก repository
   $ sudo apt update

2. อัปเกรด package ที่ติดตั้งอยู่ทั้งหมด
   $ sudo apt upgrade -y

3. ค้นหา package
   $ apt search tree
   $ apt search zip

4. ดูรายละเอียด package ก่อนติดตั้ง
   $ apt show tree

5. ติดตั้ง package
   $ sudo apt install tree -y
   $ tree ~/workshop

6. ดูรายการ package ที่ติดตั้งไว้แล้ว
   $ apt list --installed | head -20

7. ถอนการติดตั้ง package
   $ sudo apt remove tree

8. ถอนพร้อมลบ config ด้วย
   $ sudo apt purge tree

9. ลบ package ที่ไม่จำเป็นออก (cleanup)
   $ sudo apt autoremove -y
```

### แบบฝึกหัด 5b.2 — yum / dnf (CentOS / RHEL / Fedora)
```
⚠️ ใช้บนระบบ CentOS, RHEL, Fedora เท่านั้น
   (บน Ubuntu ให้ข้ามหมวดนี้ หรือใช้ sandbox/VM แทน)

1. อัปเดตรายการ package
   $ sudo yum check-update        ← yum
   $ sudo dnf check-update        ← dnf

2. อัปเกรด package ทั้งหมด
   $ sudo yum update -y
   $ sudo dnf update -y

3. ค้นหา package
   $ yum search tree
   $ dnf search tree

4. ดูรายละเอียด package
   $ yum info tree
   $ dnf info tree

5. ติดตั้ง package
   $ sudo yum install tree -y
   $ sudo dnf install tree -y

6. ดูรายการ package ที่ติดตั้ง
   $ yum list installed | head -20
   $ dnf list installed | head -20

7. ถอนการติดตั้ง
   $ sudo yum remove tree
   $ sudo dnf remove tree
```

### เปรียบเทียบ apt vs yum/dnf

| งาน | apt (Ubuntu) | yum/dnf (CentOS/RHEL) |
|-----|-------------|----------------------|
| อัปเดตรายการ | `apt update` | `yum check-update` |
| อัปเกรดทั้งหมด | `apt upgrade` | `yum update` |
| ค้นหา | `apt search` | `yum search` |
| ติดตั้ง | `apt install` | `yum install` |
| ถอน | `apt remove` | `yum remove` |
| ถอน+config | `apt purge` | `yum remove` |
| Cleanup | `apt autoremove` | `yum autoremove` |

### คำถามท้ายหมวด
- ทำไมต้องรัน `apt update` ก่อน `apt install` เสมอ?
- `apt remove` กับ `apt purge` ต่างกันอย่างไร?
- `yum` กับ `dnf` เหมือนหรือต่างกันอย่างไร?

---

## หมวดที่ 6 — โจทย์รวม (Capstone)

> ทำทีละข้อตามลำดับ ไม่ดูเฉลยจนกว่าจะลองเอง

**โจทย์:** สร้างระบบจัดเก็บ log อย่างง่าย

```
ขั้นที่ 1: สร้างโฟลเดอร์ ~/logstore/2026/07/
ขั้นที่ 2: สร้างไฟล์ app.log ใน ~/logstore/2026/07/
ขั้นที่ 3: เขียน 5 บรรทัดข้อความ (จำลอง log) ลงในไฟล์นั้น
ขั้นที่ 4: นับจำนวนบรรทัดใน app.log
ขั้นที่ 5: ค้นหาบรรทัดที่มีคำว่า "ERROR" (ให้ใส่คำนี้ใน log ด้วย)
ขั้นที่ 6: คัดลอก app.log เป็น app.log.bak
ขั้นที่ 7: แสดงโครงสร้างโฟลเดอร์ทั้งหมดด้วย find
```

---

## เฉลยโจทย์รวม

```bash
mkdir -p ~/logstore/2026/07
touch ~/logstore/2026/07/app.log

echo "[INFO] Server started" >> ~/logstore/2026/07/app.log
echo "[INFO] User logged in" >> ~/logstore/2026/07/app.log
echo "[ERROR] Database connection failed" >> ~/logstore/2026/07/app.log
echo "[INFO] Retry connection" >> ~/logstore/2026/07/app.log
echo "[INFO] Connection restored" >> ~/logstore/2026/07/app.log

wc -l ~/logstore/2026/07/app.log

grep "ERROR" ~/logstore/2026/07/app.log

cp ~/logstore/2026/07/app.log ~/logstore/2026/07/app.log.bak

find ~/logstore -type f
```

---

## สรุปคำสั่งที่ควรจำ

| กลุ่ม | คำสั่ง |
|-------|--------|
| นำทาง | `pwd`, `ls`, `cd`, `../` |
| ไฟล์/โฟลเดอร์ | `mkdir`, `touch`, `cp`, `mv`, `rm` |
| อ่าน/เขียน | `cat`, `cat -n`, `nano`, `echo`, `>`, `>>`, `head`, `tail`, `wc` |
| Link | `ln`, `ln -s` |
| Archive | `tar -czf`, `tar -xzf`, `zip`, `unzip` |
| ค้นหา | `grep`, `find`, `locate`, `whereis`, `which` |
| ดาวน์โหลด | `wget`, `curl` |
| Permissions | `chmod`, `chown`, `sudo`, `su` |
| Package Manager | `apt`, `yum`, `dnf` |
| ระบบ | `whoami`, `df`, `free`, `history`, `man` |
