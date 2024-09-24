### Git

```bash
git init
git clone https://github.com/Sameer-8080/Website-PRT-ORG.git
```
### Docker
> create `Dockerfile`

```bash
docker login
docker build -t website-prt-org-image .
docker tag website-prt-org-image:tagname torrentxx/website-prt-org-image
docker push torrentxx/website-prt-org-image:latest
```

### Kubernetes
> Enable kubernetes on docker desktop

> create `deployment.yaml` and `service.yaml`

```yml
apply -f deployment.yaml
apply -f service.yaml
kubectl get pods
kubectl get deployments
kubectl get nodes -o jsonpath="{.items[0].status.addresses[0].address}"
```