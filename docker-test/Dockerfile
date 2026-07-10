# ทำการเลือก base image (จาก docker hub) มาเป็นตัว runtime เริ่มต้น เพื่อให้สามารถ run project ได้
# ในทีนี้เราทำการเลือก node image version 18 ออกมา
FROM node:18

# กำหนด directory เริ่มต้นใน container (ตอน run ขึ้นมา)
WORKDIR /usr/src/app

# copy entrypoint script ที่จะรอฐานข้อมูลก่อนเริ่มแอป
COPY entrypoint.sh ./entrypoint.sh

# copy file package.json จากเครื่อง local เข้ามาใน container
COPY package.json ./

# ทำการลง dependency node
RUN npm install

# copy file index.js เข้ามาใน container
COPY index.js ./

# ให้สคริปต์ entrypoint รันได้
RUN chmod +x /usr/src/app/entrypoint.sh

# ทำการปล่อย port 8000 ออกมาให้ access ได้
EXPOSE 8000

# กำหนด entrypoint ให้รอ db ก่อน แล้วค่อยเริ่มแอป
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

# กำหนด command สำหรับเริ่มต้น run application (ตอน run container)
CMD ["node", "index.js"]